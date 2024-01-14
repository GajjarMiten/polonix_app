import 'dart:io' as io;

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:poloniexapp/src/data/core/enums/base_url_enum.dart';
import 'package:poloniexapp/src/data/core/enums/endpoints_enum.dart';
import 'package:poloniexapp/src/data/core/types.dart';
import 'package:poloniexapp/src/data/datasources/remote/http_result.dart';
import 'base/base_http_client.dart';
import 'interceptors/error_interceptor.dart';

class HttpClientImpl extends HttpClient {
  final Dio _dio = Dio();
  HttpClientImpl.init() {
    io.HttpOverrides.global = _MyHttpOverrides();
    _dio.options = BaseOptions(sendTimeout: 150.seconds);
    _dio.interceptors.add(ApiInterceptors());
  }

  @override
  Future<HttpResult<T>> get<T>(Endpoints endPoint,
      {required BaseUrl base,
      Map<String, dynamic>? headers,
      QueryParams? queryParams,
      ResponseModifier<T>? modifier}) {
    throw UnimplementedError();
  }

  @override
  Future<HttpResult<T>> post<T>(Endpoints endPoint, body,
      {required BaseUrl base,
      ResponseModifier<T>? modifier,
      Map<String, dynamic>? headers,
      QueryParams? queryParams}) {
    throw UnimplementedError();
  }
}

class _MyHttpOverrides extends io.HttpOverrides {
  @override
  io.HttpClient createHttpClient(io.SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (io.X509Certificate cert, String host, int port) => true;
  }
}
