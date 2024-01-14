import 'package:poloniexapp/src/data/core/enums/base_url_enum.dart';
import 'package:poloniexapp/src/data/core/enums/endpoints_enum.dart';
import 'package:poloniexapp/src/data/core/types.dart';
import 'package:poloniexapp/src/data/datasources/remote/http_result.dart';

abstract class HttpClient {
  Future<HttpResult<T>> get<T>(
    Endpoints endPoint, {
    required BaseUrl base,
    Map<String, dynamic>? headers,
    QueryParams queryParams,
    ResponseModifier<T>? modifier,
  });
  Future<HttpResult<T>> post<T>(
    Endpoints endPoint,
    dynamic body, {
    required BaseUrl base,
    ResponseModifier<T>? modifier,
    Map<String, dynamic>? headers,
    QueryParams queryParams,
  });
}
