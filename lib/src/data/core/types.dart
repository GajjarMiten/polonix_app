import 'package:dio/dio.dart';
import 'package:poloniexapp/src/data/datasources/remote/http_result.dart';


typedef QueryParams = Map<String, dynamic>?;
typedef ResponseModifier<T> = HttpResult<T> Function(
    Response<dynamic> rawResponse);