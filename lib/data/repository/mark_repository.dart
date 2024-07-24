import 'package:ajhman/data/api/dio_helper.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';

final markRepository = MarkRepository(DioHelper());

class MarkRepository implements Mark {
  final DioHelper dioHelper;

  MarkRepository(this.dioHelper);

  @override
  Future<Response> postMark(int id) async {
    try {
      Response response = await dioHelper.postRequest(
          "${ApiEndPoints.mainCourse}/$id${ApiEndPoints.mark}", null, null);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Response> deleteMark(int id) async {
    try {
      Response response = await dioHelper.deleteRequest(
          "${ApiEndPoints.mainCourse}/$id${ApiEndPoints.mark}", null);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Mark {
  Future<Response> postMark(int id);
  Future<Response> deleteMark(int id);
}
