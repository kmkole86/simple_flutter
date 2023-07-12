import 'package:either_dart/either.dart';
import 'package:simple_flutter/core/model/range.dart';
import 'package:simple_flutter/data/data_source/local_data_source.dart';
import 'package:simple_flutter/data/mappers/data_mapper.dart';

import '../../domain/entity/movie_entity.dart';
import '../../domain/repository/movie_repository.dart';
import '../../domain/use_case/get_movies_page_range_use_case.dart';
import '../mappers/entity_mapper.dart';

///repository has couple of behaviours
///
///offline first,
///calculation of what page(s) is missing in the cache (page range to support two way paggination)
///fetch missing pages
///cache fetched page
///
/// all of this behaviours are implemented as a layers around MovieRepository
///
///OfflineFirstRepositoryProxy if page range is in cache return else pass the call
///PageRangeDecorator calculate what pages are missing, pass the call with new range
///CacheDecorator call MovieRepository to fetch new pages and cache result.

class RepositoryCacheDecorator extends MovieRepository {
  final MovieRepository _repository;
  final LocalDataSource _localDataSource;
  final DataMapper _dataMapper;
  final EntityMapper _entityMapper;

  RepositoryCacheDecorator(
      {required MovieRepository repository,
      required LocalDataSource localDataSource,
      required DataMapper dataMapper,
      required EntityMapper entityMapper})
      : _repository = repository,
        _localDataSource = localDataSource,
        _dataMapper = dataMapper,
        _entityMapper = entityMapper;

  @override
  Future<Either<GetPageError, List<Page>>> getMoviePageRange(
      {required Range range}) async {
    var result = await _repository.getMoviePageRange(range: range);

    if (result.isRight) {
      await _localDataSource.insertPages(
          pages: _dataMapper.mapToPages(result.right));

      result = Right(_entityMapper
          .mapToPages(await _localDataSource.getCachedPages(range: range)));
    }

    return result;
  }
}
