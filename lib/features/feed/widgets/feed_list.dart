import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter/features/feed/bloc/feed_bloc.dart';
import 'package:simple_flutter/features/feed/bloc/feed_event.dart';

import '../../../domain/entity/movie_entity.dart';

@immutable
sealed class FeedUiItem {
  final int key;

  const FeedUiItem({required this.key});
}

@immutable
class MovieUiItem extends FeedUiItem {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;

  const MovieUiItem._(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.voteCount})
      : super(key: id);

  factory MovieUiItem({required Movie movie}) {
    return MovieUiItem._(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
        releaseDate: movie.releaseDate,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount);
  }
}

class LoadingUiItem extends FeedUiItem {
  const LoadingUiItem() : super(key: -1);
}

class ErrorUiItem extends FeedUiItem {
  const ErrorUiItem() : super(key: -2);
}

class MovieList extends StatefulWidget {
  final List<FeedUiItem> _items;

  const MovieList({super.key, required List<FeedUiItem> items})
      : _items = items;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 300) {
        context.read<FeedBloc>().add(OnBottomOfPageReached());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: widget._items.length,
        itemBuilder: (context, index) {
          final item = widget._items[index];
          switch (item) {
            case MovieUiItem _:
              return MovieItem(item: item);
            case LoadingUiItem _:
              return const LoadingItem();
            case ErrorUiItem _:
              return const ErrorItem();
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class MovieItem extends StatelessWidget {
  final MovieUiItem _item;

  const MovieItem({super.key, required MovieUiItem item}) : _item = item;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
              height: 128,
              child: Text(
                _item.title,
                overflow: TextOverflow.ellipsis,
              )),
        ));
  }
}

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 128,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textAlign: TextAlign.center, "Loading"),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: LinearProgressIndicator(
                value: null,
                semanticsLabel: 'Linear progress indicator',
              ),
            )
          ],
        ));
  }
}

class ErrorItem extends StatelessWidget {
  const ErrorItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 128,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Something went wrong..."),
            TextButton(onPressed: () {}, child: const Text("Retry"))
          ],
        ));
  }
}
