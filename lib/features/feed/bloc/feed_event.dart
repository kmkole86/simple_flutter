import 'package:flutter/foundation.dart';

@immutable
sealed class FeedEvent {}

final class OnPageCached extends FeedEvent {}

final class OnBottomOfPageReached extends FeedEvent {}

final class OnRetryClicked extends FeedEvent {}
