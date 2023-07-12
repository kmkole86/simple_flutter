import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';
import 'package:simple_flutter/features/feed/bloc/feed_event.dart';
import 'package:simple_flutter/features/feed/bloc/feed_state.dart';

import '../../../core/model/range.dart';
import '../../../domain/entity/movie_entity.dart';
import '../widgets/feed_list.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPageRangeUseCase getPageRangeUseCase;
  final FeedUiItemsMapper mapper;

  FeedBloc({required this.getPageRangeUseCase, required this.mapper})
      : super(Fetched.empty()) {
    on<OnBottomOfPageReached>(_handleBottomOfPageReached);
  }

  void _handleBottomOfPageReached(
      OnBottomOfPageReached event, Emitter<FeedState> emitter) async {
    if (state is Fetched) {
      await for (final GetPageRangeResult result
          in getPageRangeUseCase.getPageRange(
              range: Range(
                  fromInclusive: state.range.fromInclusive,
                  toExclusive: state.range.toExclusive + 1))) {
        _reduce(result: result);
      }
    }
  }

  void _reduce({required GetPageRangeResult result}) {
    switch (result) {
      case FetchInFlight _:
        {
          emit(Fetching(
              items: state.items,
              uiItems: mapper.generateItems(pages: state.items),
              range: state.range));
        }
      case Failed _:
        emit(Error(
            items: state.items,
            uiItems: mapper.generateErrorItems(pages: state.items),
            range: state.range));
      case Success _:
        {
          List<Page> pages = List.from(
              result.pages); // wrapped => sort trows ex for not modifiable list
          pages.sort((a, b) => a.ordinal.compareTo(b.ordinal));

          emit(Fetched(
              items: pages,
              uiItems: mapper.generateItems(pages: pages),
              range: pages.isEmpty
                  ? const Range(fromInclusive: 0, toExclusive: 0)
                  : Range(
                      fromInclusive: pages.first.ordinal,
                      toExclusive: pages.last.ordinal + 1)));
        }
    }
  }
}

class FeedUiItemsMapper {
  List<FeedUiItem> _generateMovieItems({required List<Page> pages}) {
    return <FeedUiItem>[
      ...pages
          .expand((page) => page.movies)
          .map((movie) => MovieUiItem(movie: movie))
          .toList()
    ];
  }

  List<FeedUiItem> generateItems({required List<Page> pages}) {
    return _generateMovieItems(pages: pages)..add(const LoadingUiItem());
  }

  List<FeedUiItem> generateErrorItems({required List<Page> pages}) {
    return _generateMovieItems(pages: pages)..add(const ErrorUiItem());
  }
}
