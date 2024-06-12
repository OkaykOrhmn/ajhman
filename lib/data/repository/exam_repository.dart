import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
import 'package:ajhman/data/model/answer_request_model.dart';
import 'package:ajhman/data/model/answer_result_model.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/exam_response_model.dart';
import 'package:ajhman/data/model/feedbacks_questions_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/model/questions_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final examRepository = ExamRepository(DioHelper());

class ExamRepository implements Examm {
  final DioHelper dioHelper;

  ExamRepository(this.dioHelper);

  @override
  Future<ExamResponseModel> getExam(int id) async {
    try {
      Response response = await dioHelper.getRequest(
          "${ApiEndPoints.mainCourse}/$id${ApiEndPoints.exam}", null);
      final postMaps = response.data;
      return ExamResponseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<AnswerResultModel> postExam(int id, AnswerRequestModel request) async {
    try {
      Response response = await dioHelper.postRequest(
          "${ApiEndPoints.mainCourse}/$id${ApiEndPoints.exam}", request,null);
      return AnswerResultModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Examm {
  Future<ExamResponseModel> getExam(int id);

  Future<AnswerResultModel> postExam(int id, AnswerRequestModel request);
}
