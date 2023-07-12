import 'package:dio/dio.dart';

import 'auth_interceptor.dart';

class DioFactory {
  const DioFactory();

  static const String _baseUrl = "https://api.themoviedb.org/3/movie/";

  Dio createClient() {
    final Dio dio = Dio(_createBaseOptions())
      ..interceptors.add(AuthInterceptor());

    // if (!kReleaseMode) {
    //   dio.interceptors.add(DebugLoggingInterceptor());
    // }

    return dio;
  }

  BaseOptions _createBaseOptions() => BaseOptions(
        baseUrl: _baseUrl,
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000),
        connectTimeout: const Duration(milliseconds: 5000),
        headers: <String, dynamic>{
          "Accept": "application/json",
        },
      );
}
