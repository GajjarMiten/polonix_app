import 'dart:io' as io;

import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:poloniexapp/src/data/core/enums/base_url_enum.dart';
import 'package:poloniexapp/src/data/core/enums/endpoints_enum.dart';
import 'package:poloniexapp/src/data/core/types.dart';
import 'package:poloniexapp/src/data/datasources/remote/exceptions/custom_exceptions.dart';
import 'package:poloniexapp/src/data/datasources/remote/helpers/helpers.dart';
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
    return _requestHandler<T>(
      endPoint,
      base,
      queryParameters: queryParams,
      modifier: modifier,
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );
  }

  @override
  Future<HttpResult<T>> post<T>(Endpoints endPoint, body,
      {required BaseUrl base,
      ResponseModifier<T>? modifier,
      Map<String, dynamic>? headers,
      QueryParams? queryParams}) {
    return _requestHandler(
      endPoint,
      base,
      data: body,
      modifier: modifier,
      queryParameters: queryParams,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
    );
  }

  Future<HttpResult<T>> _requestHandler<T>(
    Endpoints endpoint,
    BaseUrl base, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool? isSilent,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    ResponseModifier<T>? modifier,
    String? fullURL,
  }) async {
    String path = _getUrl(endpoint: endpoint, base: base);

    try {
      final res = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      final HttpResult<T> result =
          modifier?.call(res) ?? HttpResult.completed(res.data['data']);

      return result;
    } on DioException catch (error) {
      return _handleDioError<T>(error, endPoint: endpoint, isSilent: isSilent);
    } catch (error, trace) {
      final dioError = DioException(
        requestOptions: (options ?? Options()).compose(
          _dio.options,
          path,
          data: data,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onReceiveProgress,
          queryParameters: queryParameters,
          sourceStackTrace: trace,
        ),
        error: error,
        stackTrace: trace,
        message: 'flutter-error',
      );
      return _handleDioError(dioError, endPoint: endpoint, isSilent: isSilent);
    }
  }

  String _getUrl({required Endpoints endpoint, required BaseUrl base}) {
    return base.url + endpoint.url;
  }

  HttpResult<T> _handleDioError<T>(DioException err,
      {Endpoints endPoint = Endpoints.unknown, bool? isSilent}) {
    final reqOption = err.requestOptions;
    final statusCode = err.response?.statusCode;
    final internalError = err.error;

    DioException exception = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        DeadlineExceededException(reqOption),
      DioExceptionType.badResponse =>
        getExceptionForBadResponse(statusCode, reqOption),
      DioExceptionType.cancel => DioException.requestCancelled(
          requestOptions: reqOption, reason: 'new request was created'),
      DioExceptionType.connectionError =>
        NoInternetConnectionException(reqOption),
      DioExceptionType.unknown => getUnknownException(internalError, reqOption),
      DioExceptionType.badCertificate => BadCertificateException(reqOption),
    };

    exception = exception.copyWith(
      requestOptions: err.requestOptions,
      response: err.response,
      error: err.error,
      message: exception.toString(),
      stackTrace: err.stackTrace,
      type: err.type,
    );
    dynamic errorMessage = "";

    var responseData = exception.response?.data;
    if (responseData is Map) {
      errorMessage = responseData["message"] ?? responseData["error"];
    } else {
      errorMessage = exception.message ?? "";
    }

    renderCurlRepresentation(exception.requestOptions);
    return HttpResult.error(errorMessage.toString());
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
