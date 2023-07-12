import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/domain/entity/movie_entity.dart';
import 'package:simple_flutter/domain/repository/movie_repository.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';
import 'package:test/test.dart';

import 'get_page_range_use_case_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late MockMovieRepository mockMovieRepository;
  late GetPageRangeUseCase subject;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    subject = GetPageRangeUseCase(repository: mockMovieRepository);
  });

  test(
      'should emit failed with invalidRangeError if lower limit of range is negative',
      () async {
    var result = await subject
        .getPageRange(range: const Range(fromInclusive: -1, toExclusive: 0))
        .first;

    expect(result, Failed(error: GetPageError.invalidRangeError));
  });

  test(
      'should emit failed with invalidRangeError if upper limit of range is negative',
      () async {
    var result = await subject
        .getPageRange(range: const Range(fromInclusive: 0, toExclusive: -1))
        .first;

    expect(result, Failed(error: GetPageError.invalidRangeError));
  });

  test(
      'should emit failed with invalidRangeError if lower limit is greater than upper limit',
      () async {
    var result = await subject
        .getPageRange(range: const Range(fromInclusive: 1, toExclusive: 0))
        .first;

    expect(result, Failed(error: GetPageError.invalidRangeError));
  });

  test('should emit loading at start of operation', () async {
    var result = await subject
        .getPageRange(range: const Range(fromInclusive: 0, toExclusive: 1))
        .first;

    expect(result, FetchInFlight());
  });

  test('should get movie page range from repository', () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);

    provideDummy<Either<GetPageError, List<Page>>>(const Right([]));
    when(mockMovieRepository.getMoviePageRange(range: range))
        .thenAnswer((_) async => const Right([]));

    await subject.getPageRange(range: range).drain();

    verify(mockMovieRepository.getMoviePageRange(range: range));
  });

  test('should emit error followed by EndOfStream when repository call fails',
      () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);

    provideDummy<Either<GetPageError, List<Page>>>(
        const Left(GetPageError.genericError));
    when(mockMovieRepository.getMoviePageRange(range: range))
        .thenAnswer((_) async => const Left(GetPageError.genericError));

    var stream = subject.getPageRange(range: range);

    expect(
        stream,
        emitsInOrder([
          emitsThrough(Failed(error: GetPageError.genericError)),
          emitsDone
        ]));
  });

  test('should not interact with repository after failed is emitted', () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);

    provideDummy<Either<GetPageError, List<Page>>>(
        const Left(GetPageError.genericError));
    when(mockMovieRepository.getMoviePageRange(range: range))
        .thenAnswer((_) async => const Left(GetPageError.genericError));

    var stream = subject.getPageRange(range: range);

    await expectLater(stream,
        emitsInOrder([emitsThrough(Failed(error: GetPageError.genericError))]));

    verify(mockMovieRepository.getMoviePageRange(range: anyNamed("range")))
        .called(1);
  });

  test(
      'should emit success followed by EndOfStream when repository call succeed',
      () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);
    const List<Page> resultList = [];

    provideDummy<Either<GetPageError, List<Page>>>(const Right(resultList));
    when(mockMovieRepository.getMoviePageRange(range: range))
        .thenAnswer((_) async => const Right(resultList));

    var stream = subject.getPageRange(range: range);

    await expectLater(stream,
        emitsInOrder([emitsThrough(Success(pages: resultList)), emitsDone]));

    verify(mockMovieRepository.getMoviePageRange(range: anyNamed("range")))
        .called(1);
  });

  test('should not interact with repository after success is emitted',
      () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);
    const List<Page> resultList = [];

    provideDummy<Either<GetPageError, List<Page>>>(const Right(resultList));
    when(mockMovieRepository.getMoviePageRange(range: range))
        .thenAnswer((_) async => const Right(resultList));

    var stream = subject.getPageRange(range: range);

    await expectLater(
        stream, emitsInOrder([emitsThrough(Success(pages: resultList))]));

    verify(mockMovieRepository.getMoviePageRange(range: anyNamed("range")))
        .called(1);
  });
}
