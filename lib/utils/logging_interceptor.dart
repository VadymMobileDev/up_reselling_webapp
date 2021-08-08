import 'dart:async';

import 'package:dio/dio.dart';


class LoggingInterceptors extends Interceptor {
  @override
  Future<FutureOr> onRequest(RequestOptions options,
  RequestInterceptorHandler handler) async {
    print(
        "--> ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'} ${"->" + (options.baseUrl) + (options.path)}");
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    print("queryParameters:");
    options.queryParameters.forEach((k, v) => print("parameters: " + '$k: $v'));
    if (options.data.isNotEmpty) {
      print("Body: ${options.data}");
    }
    print(
        "--> END ${options.method.isNotEmpty ? options.data.toString() : 'METHOD'}");

    return options;
  }

  @override
  Future<FutureOr> onError(DioError dioError,
  ErrorInterceptorHandler handler) async {
    print(
        "<-- ${dioError.message} ${(dioError.message.isNotEmpty ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}");
    print(
        "${dioError.message.isNotEmpty ? dioError.response!.data : 'Unknown Error'}");
    print("<-- End error");
  }

  @override
  Future<FutureOr> onResponse(Response response,
      ResponseInterceptorHandler handler) async {
    print("Headers: -onResponse ");
    print(
        "<-- ${response.statusCode} ${(response.data != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    print("Headers: -");
    response.headers.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
  }
}
