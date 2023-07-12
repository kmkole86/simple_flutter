import 'dart:developer';

import 'package:dio/dio.dart';

class DebugLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //TODO start ->... new line
    log("HEADERS: ${options.headers}");
    log("METHOD: ${options.method}");
    log("QUERY PARAMS: ${options.queryParameters}");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("<-- ${response.statusCode} ${(response.requestOptions)}");
    log("Response: ${response.data}");
    log("<-- END HTTP");
    super.onResponse(response, handler);
  }
}
