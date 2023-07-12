import 'package:equatable/equatable.dart';

class PageData extends Equatable {
  final int ordinal, totalPages, totalResults;
  final List<MovieData> movies;

  const PageData(
      {required this.ordinal,
      required this.totalPages,
      required this.totalResults,
      required this.movies});

  @override
  List<Object?> get props => [ordinal, totalPages, totalResults, movies];
}

class MovieData extends Equatable {
  final int id, voteCount;
  final String title, overview, posterPath, releaseDate;
  final double voteAverage;

  const MovieData(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.voteCount});

  @override
  List<Object?> get props =>
      [id, title, overview, posterPath, releaseDate, voteAverage, voteCount];
}
