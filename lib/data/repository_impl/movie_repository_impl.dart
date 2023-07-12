import 'package:either_dart/either.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/data/data_source/remote_data_source.dart';
import 'package:simple_flutter/domain/entity/movie_entity.dart';
import 'package:simple_flutter/domain/use_case/get_movies_page_range_use_case.dart';

import '../../core/utils/range_utils.dart';
import '../../domain/repository/movie_repository.dart';
import '../mappers/entity_mapper.dart';

class MovieRepositoryImpl extends MovieRepository {
  final RemoteDataSource _remoteDataSource;
  final EntityMapper _entityMapper;
  final RangeUtils _rangeUtils;

  MovieRepositoryImpl(
      {required RemoteDataSource remoteDataSource,
      required EntityMapper entityMapper,
      required RangeUtils rangeUtils})
      : _remoteDataSource = remoteDataSource,
        _entityMapper = entityMapper,
        _rangeUtils = rangeUtils;

  @override
  Future<Either<GetPageError, List<Page>>> getMoviePageRange(
      {required Range range}) async {
    final List<int> pageOrdinals = _rangeUtils.pageOrdinals(range: range);

    try {
      final pages =
          await _remoteDataSource.fetchPages(pageOrdinals: pageOrdinals);
      return Right(_entityMapper.mapToPages(pages));
    } catch (e) {
      return const Left(GetPageError.genericError);
    }
  }
}
