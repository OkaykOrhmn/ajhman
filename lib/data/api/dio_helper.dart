import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_end_points.dart';

class DioHelper {
  final Dio _dio = Dio();

  DioHelper() {
    _dio.options.baseUrl = ApiEndPoints.baseURL;
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}
