// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PageResponse _$$_PageResponseFromJson(Map<String, dynamic> json) =>
    _$_PageResponse(
      ordinal: json['page'] as int,
      movies: (json['results'] as List<dynamic>)
          .map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$$_PageResponseToJson(_$_PageResponse instance) =>
    <String, dynamic>{
      'page': instance.ordinal,
      'results': instance.movies,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };

_$_MovieResponse _$$_MovieResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'title'],
  );
  return _$_MovieResponse(
    id: json['id'] as int,
    title: json['title'] as String,
    overview: json['overview'] as String,
    posterPath: json['poster_path'] as String,
    releaseDate: json['release_date'] as String,
    voteAverage: (json['vote_average'] as num).toDouble(),
    voteCount: json['vote_count'] as int,
  );
}

Map<String, dynamic> _$$_MovieResponseToJson(_$_MovieResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
