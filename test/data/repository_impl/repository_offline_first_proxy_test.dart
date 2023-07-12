import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/data/data_source/local_data_source.dart';
import 'package:simple_flutter/data/mappers/entity_mapper.dart';
import 'package:simple_flutter/data/model/movie_data.dart';
import 'package:simple_flutter/data/repository_impl/repository_offline_first_proxy.dart';
import 'package:simple_flutter/domain/entity/movie_entity.dart';
import 'package:simple_flutter/domain/repository/movie_repository.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';
import 'package:test/test.dart';

import 'repository_offline_first_proxy_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>(), MockSpec<LocalDataSource>()])
void main() {
  late MovieRepository mockMovieRepository;
  late LocalDataSource mockLocalDataSource;

  late RepositoryOfflineFirstProxy subject;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockLocalDataSource = MockLocalDataSource();
    subject = RepositoryOfflineFirstProxy(
        repository: mockMovieRepository,
        localDataSource: mockLocalDataSource,
        entityMapper: const EntityMapper());
  });

  test('should check for cached value', () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 4);

    when(mockLocalDataSource.isRangeCached(range: range))
        .thenAnswer((_) async => true);

    await subject.getMoviePageRange(range: range);

    verify(mockLocalDataSource.isRangeCached(range: range));
  });

  test('should return value from cache if available', () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 4);

    final List<PageData> cachedData = [
      const PageData(ordinal: 0, totalPages: 10, totalResults: 100, movies: []),
      const PageData(ordinal: 1, totalPages: 10, totalResults: 100, movies: []),
      const PageData(ordinal: 2, totalPages: 10, totalResults: 100, movies: []),
      const PageData(ordinal: 3, totalPages: 10, totalResults: 100, movies: [])
    ];

    final List<Page> cachedDomain = [
      const Page(ordinal: 0, totalPages: 10, totalResults: 100, movies: []),
      const Page(ordinal: 1, totalPages: 10, totalResults: 100, movies: []),
      const Page(ordinal: 2, totalPages: 10, totalResults: 100, movies: []),
      const Page(ordinal: 3, totalPages: 10, totalResults: 100, movies: [])
    ];

    when(mockLocalDataSource.isRangeCached(range: range))
        .thenAnswer((_) async => true);

    when(mockLocalDataSource.getCachedPages(range: range))
        .thenAnswer((_) async => cachedData);

    final result = await subject.getMoviePageRange(range: range);

    expect(result.right, cachedDomain);
  });

  test('should pass call if range not in cache', () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 5);

    when(mockLocalDataSource.isRangeCached(range: range))
        .thenAnswer((_) async => false);

    provideDummy<Either<GetPageError, List<Page>>>(const Right([]));
    when(mockMovieRepository.getMoviePageRange(range: range))
        .thenAnswer((realInvocation) async => const Right([]));

    await subject.getMoviePageRange(range: range);

    verify(mockMovieRepository.getMoviePageRange(range: range));
  });
}
