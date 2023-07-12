import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../core/model/range.dart';
import '../../../domain/entity/movie_entity.dart';
import '../widgets/feed_list.dart';

@immutable
sealed class FeedState extends Equatable {
  final List<Page> items;
  final List<FeedUiItem> uiItems;
  final Range range;

  const FeedState(
      {required this.items, required this.uiItems, required this.range});

  @override
  List<Object?> get props => [items, uiItems, range];
}

final class Fetching extends FeedState {
  const Fetching(
      {required super.items, required super.uiItems, required super.range});
}

final class Fetched extends FeedState {
  const Fetched(
      {required super.items, required super.uiItems, required super.range});

  static FeedState empty() {
    return const Fetched(
        items: [], uiItems: [], range: Range(fromInclusive: 0, toExclusive: 0));
  }
}

final class Error extends FeedState {
  const Error(
      {required super.items, required super.uiItems, required super.range});
}

final class EndOfList extends FeedState {
  const EndOfList(
      {required super.items, required super.uiItems, required super.range});
}
