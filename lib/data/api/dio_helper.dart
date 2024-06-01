import 'dart:io';

import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/splash_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../shared_preferences/auth_token.dart';
import 'api_end_points.dart';
import 'options.dart';

class DioHelper {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiEndPoints.baseURL,
    connectTimeout: const Duration(milliseconds: 30000),
    contentType: ContentType.json.toString(),
    responseType: ResponseType.json,
  ));

  DioHelper() {
    initial();
  }

  Future<void> initial() async {
    _dio.interceptors.add(PrettyDioLogger());

    return;
  }

  Dio get sendRequest => _dio;

  Future<Response> getRequest(String apiEndPoint) async {
    return await sendRequest.get(apiEndPoint, options: await getDioOptions());
  }

  Future<Response> putRequest(String apiEndPoint,Object? data,) async {
    return await sendRequest.put(apiEndPoint,data: data, options: await getDioOptions());
  }

  Future<Response> postRequest(String apiEndPoint, Object? data,
      Map<String, dynamic>? queryParameters) async {
    return await sendRequest.post(apiEndPoint,
        data: data,
        queryParameters: queryParameters,
        options: await getDioOptions());
  }
}
