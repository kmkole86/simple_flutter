import '../../domain/entity/movie_entity.dart';
import '../model/movie_data.dart';

///mapping could be done in a lot of ways, model ext entity or
///could be replaced by model extensions method,
///native android(kotlin) => extensions method doesn't play nice with
///with throw ex, haven't check for flutter, till than we will go with mappers
class DataMapper {
  const DataMapper();

  PageData mapToPage(Page data) {
    return PageData(
        ordinal: data.ordinal,
        totalPages: data.totalPages,
        totalResults: data.totalResults,
        movies: mapToMovies(data.movies));
  }

  List<PageData> mapToPages(List<Page> data) {
    return data.map((p) => mapToPage(p)).toList();
  }

  MovieData mapToMovie(Movie data) {
    return MovieData(
        id: data.id,
        title: data.title,
        overview: data.overview,
        posterPath: data.posterPath,
        releaseDate: data.releaseDate,
        voteAverage: data.voteAverage,
        voteCount: data.voteCount);
  }

  List<MovieData> mapToMovies(List<Movie> data) {
    return data.map((m) => mapToMovie(m)).toList();
  }
}
