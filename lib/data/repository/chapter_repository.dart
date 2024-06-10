import 'package:ajhman/core/enum/tags.dart';
import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final chapterRepository = ChapterRepository(DioHelper());

class ChapterRepository implements Chapter {
  final DioHelper dioHelper;

  ChapterRepository(this.dioHelper);

  @override
  Future<ChapterModel> getChapter(int chapter, int subchapter) async {
    try {
      Response response = await dioHelper.getRequest(
          "${ApiEndPoints.chapter}/$chapter${ApiEndPoints.subchapter}/$subchapter",null);
      final postMaps = response.data;
      return ChapterModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Chapter {
  Future<ChapterModel> getChapter(int chapter, int subchapter);
}
