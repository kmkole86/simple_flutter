import 'package:simple_flutter/data/model/movie_data.dart';

import '../../domain/entity/movie_entity.dart';

///mapping could be done in a lot of ways, model ext entity or
///could be replaced by model extensions method,
///native android(kotlin) => extensions method doesn't play nice with
///with throw ex, haven't check for flutter, till than we will go with mappers
class EntityMapper {
  const EntityMapper();

  Page mapToPage(PageData data) {
    return Page(
        ordinal: data.ordinal,
        totalPages: data.totalPages,
        totalResults: data.totalResults,
        movies: mapToMovies(data.movies));
  }

  List<Page> mapToPages(List<PageData> data) {
    return data.map((p) => mapToPage(p)).toList();
  }

  Movie mapToMovie(MovieData data) {
    return Movie(
        id: data.id,
        title: data.title,
        overview: data.overview,
        posterPath: data.posterPath,
        releaseDate: data.releaseDate,
        voteAverage: data.voteAverage,
        voteCount: data.voteCount);
  }

  List<Movie> mapToMovies(List<MovieData> data) {
    return data.map((m) => mapToMovie(m)).toList();
  }
}
