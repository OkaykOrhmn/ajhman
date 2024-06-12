import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/model/roadmap_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final courseRepository = CourseRepository(DioHelper());

class CourseRepository implements Course {
  final DioHelper dioHelper;

  CourseRepository(this.dioHelper);

  @override
  Future<CourseMainResponseModel> getMainCurse(int courseId) async {
    try {
      Response response = await dioHelper.getRequest("${ApiEndPoints.mainCourse}/$courseId",null);
      final postMaps = response.data;
      return CourseMainResponseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<RoadmapModel> getRoadmap(int courseId) async{
    try {
      Response response = await dioHelper.getRequest("${ApiEndPoints.mainCourse}/$courseId${ApiEndPoints.roadmap}",null);
      final postMaps = response.data;
      return RoadmapModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }

  }

  @override
  Future<List<NewCourseCardModel>> getSearch( String type, String search) async{
    try {
      Map<String, dynamic>? q = {
        "type": type,
        "q": search,
      };
      Response response = await dioHelper.getRequest(ApiEndPoints.mainCourse,q);
      final List<dynamic> postMaps = response.data;
      return postMaps.map((e) => NewCourseCardModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Course {
  Future<CourseMainResponseModel> getMainCurse(int courseId);
  Future<RoadmapModel> getRoadmap(int courseId);
  Future<List<NewCourseCardModel>> getSearch(String type,String search);
}
