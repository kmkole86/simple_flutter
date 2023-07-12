import 'package:either_dart/either.dart';
import 'package:simple_flutter/data/mappers/entity_mapper.dart';

import '../../core/model/range.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/repository/movie_repository.dart';
import '../../domain/use_case/get_movies_page_range_use_case.dart';
import '../data_source/local_data_source.dart';

///repository has couple of behaviours
///
///offline first,
///calculation of what page(s) is missing in the cache (page range to support two way pagination)
///fetch missing pages
///cache fetched page
///
/// all of this behaviours are implemented as a layers around MovieRepository
///
///OfflineFirstRepositoryProxy if page range is in cache return else pass the call
///PageRangeDecorator calculate what pages are missing, pass the call with new range
///CacheDecorator call MovieRepository to fetch new pages and cache result.

class RepositoryOfflineFirstProxy extends MovieRepository {
  final MovieRepository _repository;
  final LocalDataSource _localDataSource;
  final EntityMapper _mapper;

  RepositoryOfflineFirstProxy(
      {required MovieRepository repository,
      required LocalDataSource localDataSource,
      required EntityMapper entityMapper})
      : _repository = repository,
        _localDataSource = localDataSource,
        _mapper = entityMapper;

  @override
  Future<Either<GetPageError, List<Page>>> getMoviePageRange(
      {required Range range}) async {
    if (!(await _localDataSource.isRangeCached(range: range))) {
      Either<GetPageError, List<Page>> result =
          await _repository.getMoviePageRange(range: range);

      if (result.isLeft) {
        return result;
      }
    }

    return Right(_mapper
        .mapToPages(await _localDataSource.getCachedPages(range: range)));
  }
}
