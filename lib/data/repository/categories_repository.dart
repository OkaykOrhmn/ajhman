import 'package:ajhman/core/enum/tags.dart';
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

final categoriesRepository = CategoriesRepository(DioHelper());

class CategoriesRepository implements Category {
  final DioHelper dioHelper;

  CategoriesRepository(this.dioHelper);

  @override
  Future<List<NewCourseCardModel>> getCards(List<int> categories,Tags tag) async {
    try {
      Map<String, dynamic>? q = { "categories": categories};
      if(tag.value !=null){
        q.addAll({"tag":tag.value});
      }
      Response response =
          await dioHelper.getRequest(ApiEndPoints.mainCourse, q);
      final List<dynamic> postMaps = response.data;
      return postMaps.map((e) => NewCourseCardModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Category {
  Future<List<NewCourseCardModel>> getCards(List<int> categories,Tags tag);
}
