import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final learningRepository = LearningRepository(DioHelper());

class LearningRepository implements Learning {
  final DioHelper dioHelper;

  LearningRepository(this.dioHelper);

  @override
  Future<List<NewCourseCardModel>> getCards(String path) async {
    try {
      Response response = await dioHelper.getRequest(ApiEndPoints.mainCourse+path,null);
      final List<dynamic> postMaps = response.data;
      return postMaps.map((e) => NewCourseCardModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Learning {
  Future<List<NewCourseCardModel>> getCards(String path);
}
