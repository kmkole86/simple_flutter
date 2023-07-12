import 'package:either_dart/either.dart';

import '../../core/model/range.dart';
import '../../core/utils/range_utils.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/repository/movie_repository.dart';
import '../../domain/use_case/get_movies_page_range_use_case.dart';
import '../data_source/local_data_source.dart';

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

class RepositoryPageRangeDecorator extends MovieRepository {
  final MovieRepository _repository;
  final LocalDataSource _localDataSource;
  final RangeUtils _rangeUtils;

  RepositoryPageRangeDecorator(
      {required MovieRepository repository,
      required LocalDataSource localDataSource,
      required RangeUtils rangeUtils})
      : _repository = repository,
        _localDataSource = localDataSource,
        _rangeUtils = rangeUtils;

  @override
  Future<Either<GetPageError, List<Page>>> getMoviePageRange(
      {required Range range}) async {
    Range cachedRange =
        await _localDataSource.getCachedRangeWithinLimits(range: range);

    Range missingRange =
        _rangeUtils.rangeDifference(range1: range, range2: cachedRange);

    return await _repository.getMoviePageRange(range: missingRange);
  }
}
