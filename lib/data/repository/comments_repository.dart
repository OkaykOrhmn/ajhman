import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';

final commentsRepository = CommentsRepository(DioHelper());

class CommentsRepository implements Comment {
  final DioHelper dioHelper;

  CommentsRepository(this.dioHelper);

  @override
  Future<List<CommentsResponseModel>> getComments(
      int chapter, int subchapter) async {
    try {
      Response response = await dioHelper.getRequest(
          "${ApiEndPoints.chapter}/$chapter${ApiEndPoints.subchapter}/$subchapter${ApiEndPoints.comment}",null);
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

  @override
  Future<CommentsResponseModel> addComment(
      int chapter, int subchapter, Object? data) async {
    try {
      Response response = await dioHelper.postRequest(
          "${ApiEndPoints.chapter}/$chapter${ApiEndPoints.subchapter}/$subchapter${ApiEndPoints.comment}",
          data,
          null);
      final postMaps = response.data;
      return CommentsResponseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Comment {
  Future<List<CommentsResponseModel>> getComments(int chapter, int subchapter);

  Future<Response> putFeed(
      int chapter, int subchapter, int commentId, bool? feed);

  Future<CommentsResponseModel> addComment(
      int chapter, int subchapter, Object? data);
}
