import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/data/data_source/local_data_source.dart';
import 'package:simple_flutter/data/mappers/data_mapper.dart';
import 'package:simple_flutter/data/mappers/entity_mapper.dart';
import 'package:simple_flutter/data/model/movie_data.dart';
import 'package:simple_flutter/data/repository_impl/repository_cache_decorator.dart';
import 'package:simple_flutter/domain/entity/movie_entity.dart';
import 'package:simple_flutter/domain/repository/movie_repository.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';
import 'package:test/test.dart';

import 'repository_cache_decorator_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>(), MockSpec<LocalDataSource>()])
void main() {
  late MockMovieRepository mockMovieRepository;
  late MockLocalDataSource mockLocalDataSource;
  late RepositoryCacheDecorator subject;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockLocalDataSource = MockLocalDataSource();
    subject = RepositoryCacheDecorator(
        repository: mockMovieRepository,
        localDataSource: mockLocalDataSource,
        entityMapper: const EntityMapper(),
        dataMapper: const DataMapper());
  });

  test("should delegate call to repository", () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);

    provideDummy<Either<GetPageError, List<Page>>>(const Right([]));
    when(mockMovieRepository.getMoviePageRange(range: range))
        .thenAnswer((realInvocation) async => const Right([]));

    await subject.getMoviePageRange(range: range);

    verify(mockMovieRepository.getMoviePageRange(range: range));
  });

  test(
      "when delegated call to repository execute successfully, should cache result and return range from cache",
      () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);

    final List<Page> pagesDomain = [
      const Page(ordinal: 0, totalPages: 10, totalResults: 100, movies: []),
      const Page(ordinal: 1, totalPages: 10, totalResults: 100, movies: []),
      const Page(ordinal: 2, totalPages: 10, totalResults: 100, movies: [])
    ];

    final List<PageData> pagesData = [
      const PageData(ordinal: 0, totalPages: 10, totalResults: 100, movies: []),
      const PageData(ordinal: 1, totalPages: 10, totalResults: 100, movies: []),
      const PageData(ordinal: 2, totalPages: 10, totalResults: 100, movies: [])
    ];

    provideDummy<Either<GetPageError, List<Page>>>(Right(pagesDomain));
    when(mockMovieRepository.getMoviePageRange(range: range))
        .thenAnswer((_) async => Right(pagesDomain));

    when(mockLocalDataSource.insertPages(pages: anyNamed("pages")))
        .thenAnswer((_) async => {});

    when(mockLocalDataSource.getCachedPages(range: range))
        .thenAnswer((_) async => pagesData);

    final Either<GetPageError, List<Page>> result =
        await subject.getMoviePageRange(range: range);

    verify(mockLocalDataSource.insertPages(pages: pagesData));
    verify(mockLocalDataSource.getCachedPages(range: range));
    expect(result.right, pagesDomain);
  });

  test("when propagated call to repository fails, should return call result",
      () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);

    provideDummy<Either<GetPageError, List<Page>>>(
        const Left(GetPageError.genericError));
    when(mockMovieRepository.getMoviePageRange(range: range)).thenAnswer(
        (realInvocation) async => const Left(GetPageError.genericError));

    var result = await subject.getMoviePageRange(range: range);

    expect(result, const Left(GetPageError.genericError));
  });
}
