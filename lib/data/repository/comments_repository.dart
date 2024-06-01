import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final commentsRepository = CommentsRepository(DioHelper());

class CommentsRepository implements ProfileInformation {
  final DioHelper dioHelper;

  CommentsRepository(this.dioHelper);

  @override
  Future<List<CommentsResponseModel>> getComments(
      int chapter, int subchapter) async {
    try {
      Response response = await dioHelper.getRequest(
          "${ApiEndPoints.chapter}/$chapter${ApiEndPoints.subchapter}/$subchapter${ApiEndPoints.comment}");
      final List<dynamic> postMaps = response.data;
      return postMaps.map((e) => CommentsResponseModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Response> putFeed(
      int chapter, int subchapter, int commentId, bool? feed) async {
    try {
      Response response = await dioHelper.putRequest(
          "${ApiEndPoints.chapter}/$chapter${ApiEndPoints.subchapter}/$subchapter${ApiEndPoints.comment}/$commentId",
          {"liked": feed});
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class ProfileInformation {
  Future<List<CommentsResponseModel>> getComments(int chapter, int subchapter);

  Future<Response> putFeed(int chapter, int subchapter, int commentId, bool? feed);
}
