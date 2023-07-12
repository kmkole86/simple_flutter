import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';
part 'response.g.dart';

@freezed
class PageResponse with _$PageResponse {
  const PageResponse._();

  const factory PageResponse(
          {@JsonKey(name: 'page') required int ordinal,
          @JsonKey(name: 'results') required List<MovieResponse> movies,
          @JsonKey(name: 'total_pages') required int totalPages,
          @JsonKey(name: 'total_results') required int totalResults}) =
      _PageResponse;

  factory PageResponse.fromJson(Map<String, dynamic> json) =>
      _$PageResponseFromJson(json);
}

@freezed
class MovieResponse with _$MovieResponse {
  const MovieResponse._();

  const factory MovieResponse(
      {@JsonKey(name: 'id', required: true) required int id,
      @JsonKey(name: 'title', required: true) required String title,
      @JsonKey(name: 'overview') required String overview,
      @JsonKey(name: 'poster_path') required String posterPath,
      @JsonKey(name: 'release_date') required String releaseDate,
      @JsonKey(name: 'vote_average') required double voteAverage,
      @JsonKey(name: 'vote_count') required int voteCount}) = _MovieResponse;

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}
