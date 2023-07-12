import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:simple_flutter/data/remote_data_source/model/response.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/movie/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('top_rated')
  Future<PageResponse> fetchPage({@Query('page') required int page});
}
