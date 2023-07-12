import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/core/utils/range_utils.dart';
import 'package:simple_flutter/data/data_source/local_data_source.dart';
import 'package:simple_flutter/data/repository_impl/repository_page_range_decorator.dart';
import 'package:simple_flutter/domain/entity/movie_entity.dart';
import 'package:simple_flutter/domain/repository/movie_repository.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';
import 'package:test/test.dart';

import 'repository_page_range_decorator_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MovieRepository>(),
  MockSpec<LocalDataSource>(),
  MockSpec<RangeUtils>()
])
void main() {
  late MockMovieRepository mockMovieRepository;
  late MockLocalDataSource mockLocalDataSource;
  late MockRangeUtils mockRangeUtils;

  late RepositoryPageRangeDecorator subject;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockLocalDataSource = MockLocalDataSource();
    mockRangeUtils = MockRangeUtils();

    subject = RepositoryPageRangeDecorator(
        repository: mockMovieRepository,
        localDataSource: mockLocalDataSource,
        rangeUtils: mockRangeUtils);
  });

  test('should check for cached range', () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);

    when(mockLocalDataSource.getCachedRangeWithinLimits(range: range))
        .thenAnswer((_) async => range);

    provideDummy<Either<GetPageError, List<Page>>>(const Right([]));
    await subject.getMoviePageRange(range: range);

    verify(mockLocalDataSource.getCachedRangeWithinLimits(range: range));
  });

  test("should calculate missing range", () async {
    const Range range1 = Range(fromInclusive: 0, toExclusive: 5);
    const Range range2 = Range(fromInclusive: 0, toExclusive: 7);
    const Range cachedRange = Range(fromInclusive: 0, toExclusive: 3);

    const Range missingRange1 = Range(fromInclusive: 3, toExclusive: 5);
    const Range missingRange2 = Range(fromInclusive: 3, toExclusive: 7);

    when(mockLocalDataSource.getCachedRangeWithinLimits(
            range: anyNamed("range")))
        .thenAnswer((_) async => cachedRange);

    provideDummy<Either<GetPageError, List<Page>>>(const Right([]));
    when(mockMovieRepository.getMoviePageRange(range: anyNamed("range")))
        .thenAnswer((_) async => const Right([]));

    when(mockRangeUtils.rangeDifference(range1: range1, range2: cachedRange))
        .thenReturn(missingRange1);

    await subject.getMoviePageRange(range: range1);

    verify(mockMovieRepository.getMoviePageRange(range: missingRange1));

    when(mockRangeUtils.rangeDifference(range1: range2, range2: cachedRange))
        .thenReturn(missingRange2);

    await subject.getMoviePageRange(range: range2);

    verify(mockMovieRepository.getMoviePageRange(range: missingRange2));
  });

  test('should propagate call to repository with the missing range', () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 5);
    const Range cachedRange = Range(fromInclusive: 0, toExclusive: 3);

    const Range missingRange = Range(fromInclusive: 3, toExclusive: 5);

    final List<Page> cachedDomain = [
      const Page(ordinal: 3, totalPages: 10, totalResults: 100, movies: []),
      const Page(ordinal: 4, totalPages: 10, totalResults: 100, movies: []),
      const Page(ordinal: 5, totalPages: 10, totalResults: 100, movies: [])
    ];

    when(mockLocalDataSource.getCachedRangeWithinLimits(range: range))
        .thenAnswer((_) async => cachedRange);

    provideDummy<Either<GetPageError, List<Page>>>(Right(cachedDomain));
    when(mockMovieRepository.getMoviePageRange(range: missingRange))
        .thenAnswer((_) async => Right(cachedDomain));

    when(mockRangeUtils.rangeDifference(range1: range, range2: cachedRange))
        .thenReturn(missingRange);

    await subject.getMoviePageRange(range: range);

    verify(mockMovieRepository.getMoviePageRange(range: missingRange));
  });
}
