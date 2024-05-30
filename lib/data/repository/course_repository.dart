import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final courseRepository = CourseRepository(DioHelper());

class CourseRepository implements ProfileInformation {
  final DioHelper dioHelper;

  CourseRepository(this.dioHelper);

  @override
  Future<CourseMainResponseModel> getMainCurse(int categoriesId) async {
    try {
      Response response = await dioHelper.getRequest(ApiEndPoints.mainCourse+categoriesId.toString());
      final postMaps = response.data;
      return CourseMainResponseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class ProfileInformation {
  Future<CourseMainResponseModel> getMainCurse(int categoriesId);
}
