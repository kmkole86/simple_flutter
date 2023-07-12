import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['api_key'] = "a794ee27f47722d30bc1c67e3df3522a";
    super.onRequest(options, handler);
  }
}
