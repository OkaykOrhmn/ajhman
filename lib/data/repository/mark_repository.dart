import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final markRepository = MarkRepository(DioHelper());

class MarkRepository implements Mark {
  final DioHelper dioHelper;

  MarkRepository(this.dioHelper);

  @override
  Future<Response> postMark(int id) async {
    try {
      Response response = await dioHelper.postRequest("${ApiEndPoints.mainCourse}/$id${ApiEndPoints.mark}",null,null);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Response> deleteMark(int id) async{
    try {
      Response response = await dioHelper.deleteRequest("${ApiEndPoints.mainCourse}/$id${ApiEndPoints.mark}",null);
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
