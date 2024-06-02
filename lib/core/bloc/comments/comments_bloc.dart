import 'package:ajhman/core/enum/comment.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/model/add_comment_request_model.dart';
import 'package:ajhman/data/model/add_comment_response_model.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/data/repository/comments_repository.dart';
import 'package:ajhman/data/shared_preferences/profile_data.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../enum/state_status.dart';

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(const CommentsState()) {
    on<CommentsEvent>((event, emit) async {
      var result = state;

      if (event is GetComments) {
        try {
          List<CommentsResponseModel> response = await commentsRepository
              .getComments(event.chapter, event.subChapter);
          result = CommentsState(
              status: CommentStatus.success,
              type: ApiEndPoints.comment,
              data: response);
          emit(result);
        } on DioError catch (e) {
          result = CommentsState(
              status: CommentStatus.fail,
              type: ApiEndPoints.comment,
              data: e.response!.data);
          emit(result);
        }
      }
      if (event is ChangeFeedComment) {
        List<CommentsResponseModel> responseModel = state.data;
        void _change(dynamic element) {
          if (element.id == event.comment.id) {
            element.userFeedback = event.comment.userFeedback;
            element.dislikes = event.comment.dislikes;
            element.likes = event.comment.likes;
          }
        }

        emit(result.copyWith(
            status: CommentStatus.changeStatus,
            type: '',
            data: responseModel,
            commentId: event.comment.id));

        late bool success;

        try {
          final response = await commentsRepository.putFeed(event.chapter,
              event.subChapter, event.comment.id!, event.comment.userFeedback);
          if (response.statusCode! >= 200 && response.statusCode! <= 300) {
            success = true;
          } else {
            success = false;
          }
        } on DioError catch (e) {
          success = false;
        }

        if (success) {
          responseModel.forEach((element) {
            if (event.commentType == CommentType.reply) {
              element.replies!.forEach((element) {
                _change(element);
              });
            } else {
              _change(element);
            }
          });
        }

        emit(result.copyWith(
            status: CommentStatus.success,
            type: '',
            data: responseModel,
            commentId: event.comment.id));
      }
      if (event is AddComment) {
        List<CommentsResponseModel> responseModel = state.data;
        emit(result.copyWith(
            status: CommentStatus.addComment, type: '', data: responseModel));

        try {
          AddCommentResponseModel response = await commentsRepository
              .addComment(event.chapter, event.subChapter, event.comment);
          final profile = await getProfile();
          if (response.commentId == null) {
            responseModel.insert(
                0,
                CommentsResponseModel(
                    id: response.id,
                    text: response.text,
                    createdAt: response.createdAt,
                    dislikes: 0,
                    likes: 0,
                    replies: [],
                    resource: response.resource,
                    user: User(id: response.userId, name: profile.name),
                    userFeedback: null));
          } else {
            responseModel.forEach((element) {
              if (element.id == response.commentId) {
                element.replies!.add(Replies(
                    id: response.id,
                    userFeedback: null,
                    user: User(id: response.userId, name: profile.name),
                    resource: response.resource,
                    likes: 0,
                    dislikes: 0,
                    createdAt: response.createdAt,
                    text: response.text,
                    replyUser: User(
                        id: response.replyUser!.id,
                        name: response.replyUser!.name)));
              }
            });
          }
          emit(result.copyWith(
              status: CommentStatus.success, type: '', data: responseModel));
        } on DioError catch (e) {
          emit(result.copyWith(
              status: CommentStatus.success, type: '', data: responseModel));
        }
      }
    });
  }
}
