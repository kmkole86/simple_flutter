import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/core/utils/range_utils.dart';
import 'package:simple_flutter/data/data_source/remote_data_source.dart';
import 'package:simple_flutter/data/mappers/entity_mapper.dart';
import 'package:simple_flutter/data/model/movie_data.dart';
import 'package:simple_flutter/data/repository_impl/movie_repository_impl.dart';
import 'package:simple_flutter/domain/entity/movie_entity.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';
import 'package:test/test.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RemoteDataSource>(), MockSpec<RangeUtils>()])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockRangeUtils mockRangeUtils;
  late MovieRepositoryImpl subject;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockRangeUtils = MockRangeUtils();
    subject = MovieRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        entityMapper: const EntityMapper(),
        rangeUtils: mockRangeUtils);
  });

  test("should generate ordinals from range", () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);
    const List<int> pageOrdinals = [0, 1, 2];
    const Either<GetPageError, List<Page>> result = Right(<Page>[]);

    when(mockRangeUtils.pageOrdinals(range: range)).thenReturn(pageOrdinals);

    await subject.getMoviePageRange(range: range);

    verify(mockRangeUtils.pageOrdinals(range: range));
  });

  test("should calculate missing pages", () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);
    const List<int> pageOrdinals = [0, 1, 2];

    when(mockRangeUtils.pageOrdinals(range: anyNamed("range")))
        .thenReturn(pageOrdinals);

    await subject.getMoviePageRange(range: range);

    verify(mockRangeUtils.pageOrdinals(range: range));
  });

  test("should fetch missing pages", () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);
    const List<int> pageOrdinals = [0, 1, 2];
    const List<PageData> response = <PageData>[];

    when(mockRangeUtils.pageOrdinals(range: range)).thenReturn(pageOrdinals);

    when(mockRemoteDataSource.fetchPages(pageOrdinals: pageOrdinals))
        .thenAnswer((_) async => response);

    await subject.getMoviePageRange(range: range);

    verify(mockRemoteDataSource.fetchPages(pageOrdinals: pageOrdinals));
  });

  test("should return fetched data if fetch successful", () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);
    const List<int> pageOrdinals = [0, 1, 2];
    const List<PageData> response = <PageData>[];
    const List<Page> resultMatchValue = <Page>[];

    when(mockRangeUtils.pageOrdinals(range: range)).thenReturn(pageOrdinals);

    when(mockRemoteDataSource.fetchPages(pageOrdinals: pageOrdinals))
        .thenAnswer((_) async => response);

    final result = await subject.getMoviePageRange(range: range);

    expect(result.right, resultMatchValue);
  });

  test("should return error if fetch unsuccessful", () async {
    const Range range = Range(fromInclusive: 0, toExclusive: 3);
    const List<int> pageOrdinals = [0, 1, 2];

    when(mockRangeUtils.pageOrdinals(range: range)).thenReturn(pageOrdinals);

    when(mockRemoteDataSource.fetchPages(pageOrdinals: pageOrdinals))
        .thenThrow(Exception());

    final result = await subject.getMoviePageRange(range: range);

    expect(result.left, GetPageError.genericError);
  });
}
