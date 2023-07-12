import 'package:either_dart/either.dart';

import '../../core/model/range.dart';
import '../entity/movie_entity.dart';
import '../use_case/get_movies_page_range_use_case.dart';

abstract class MovieRepository {
  Future<Either<GetPageError, List<Page>>> getMoviePageRange(
      {required Range range});
}
