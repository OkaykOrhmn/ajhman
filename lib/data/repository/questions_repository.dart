import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/feedbacks_questions_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/model/questions_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final questionsRepository = QuestionsRepository(DioHelper());

class QuestionsRepository implements Questions {
  final DioHelper dioHelper;

  QuestionsRepository(this.dioHelper);

  @override
  Future<QuestionsModel> getQuestions(int id) async {
    try {
      Response response =
          await dioHelper.getRequest("${ApiEndPoints.mainCourse}/$id${ApiEndPoints.question}", null);
      final postMaps = response.data;
      return QuestionsModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Response> putQuestions(int id,
      FeedbacksQuestionsModel feedbacksQuestionsModel) async {
    try {
      Response response =
      await dioHelper.putRequest("${ApiEndPoints.mainCourse}/$id${ApiEndPoints.question}", feedbacksQuestionsModel);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Questions {
  Future<QuestionsModel> getQuestions(int id);

  Future<Response> putQuestions(int id,
      FeedbacksQuestionsModel feedbacksQuestionsModel);
}
