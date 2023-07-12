import 'package:simple_flutter/data/local_data_source/simple_database.dart';

import '../model/movie_data.dart';

///since the Drift (room<|>moor) generates models, its not
///good practice to depend on it in higher level code,
///so this is one layer of separation

///could be replaced by model extensions method,
///native android(kotlin) => extensions method doesn't play nice with
///with throw ex, haven't check for flutter, till than we will go with mappers
class DbModelMapper {
  const DbModelMapper();

  PageDbModel mapToPageDb(PageData data) {
    return PageDbModel(
        ordinal: data.ordinal,
        totalPages: data.totalPages,
        totalResults: data.totalResults);
  }

  MovieData mapToMovieData(
      {required int pageOrdinal, required MovieDbModel data}) {
    return MovieData(
        id: data.id,
        title: data.title,
        overview: data.overview,
        posterPath: data.posterPath,
        releaseDate: data.releaseDate,
        voteAverage: data.voteAverage,
        voteCount: data.voteCount);
  }

  List<MovieData> mapToMoviesData(
      {required int pageOrdinal, required List<MovieDbModel> data}) {
    return data
        .map((movie) => mapToMovieData(pageOrdinal: pageOrdinal, data: movie))
        .toList();
  }

  MovieDbModel mapToMovieDb(
      {required int pageOrdinal, required MovieData data}) {
    return MovieDbModel(
        id: data.id,
        title: data.title,
        overview: data.overview,
        posterPath: data.posterPath,
        releaseDate: data.releaseDate,
        voteAverage: data.voteAverage,
        voteCount: data.voteCount,
        pageOrdinal: pageOrdinal);
  }

  List<MovieDbModel> mapToMoviesDb(
      {required int pageOrdinal, required List<MovieData> data}) {
    return data
        .map((movie) => mapToMovieDb(pageOrdinal: pageOrdinal, data: movie))
        .toList();
  }
}
