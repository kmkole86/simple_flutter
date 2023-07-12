import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_flutter/domain/repository/movie_repository.dart';

import '../../core/model/range.dart';
import '../entity/movie_entity.dart';

class GetPageRangeUseCase {
  final MovieRepository _repository;

  GetPageRangeUseCase({required MovieRepository repository})
      : _repository = repository;

  Stream<GetPageRangeResult> getPageRange({required Range range}) async* {
    if (range.fromInclusive < 0 ||
        range.toExclusive < 0 ||
        range.fromInclusive > range.toExclusive) {
      yield Failed(error: GetPageError.invalidRangeError);
    }
    yield FetchInFlight();

    var result = await _repository.getMoviePageRange(range: range);

    yield* result.fold((left) async* {
      yield Failed(error: GetPageError.genericError);
    }, (right) async* {
      yield Success(pages: right);
    });
  }
}

@immutable
sealed class GetPageRangeResult {}

final class Success extends GetPageRangeResult {
  final List<Page> pages;

  Success({required this.pages});
}

final class Failed extends GetPageRangeResult {
  final GetPageError error;

  Failed({required this.error});
}

final class FetchInFlight extends GetPageRangeResult {}

///TODO ("add all possible errors")
enum GetPageError {
  genericError,
  invalidRangeError;
}
