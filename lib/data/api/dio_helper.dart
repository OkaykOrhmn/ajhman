import 'dart:io';

import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/splash_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../shared_preferences/auth_token.dart';
import 'api_end_points.dart';


class DioHelper {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: ApiEndPoints.baseURL,
      connectTimeout: const Duration(milliseconds: 30000),
      contentType: ContentType.json.toString(),
      responseType: ResponseType.json,));

  DioHelper() {
    initial();
  }

  Future<void> initial() async {
    _dio.interceptors.add(PrettyDioLogger());

    return;

  }

  Dio get sendRequest => _dio;

}
