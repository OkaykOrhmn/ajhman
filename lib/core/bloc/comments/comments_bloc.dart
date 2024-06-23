import 'package:ajhman/core/enum/comment.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/model/add_comment_request_model.dart';
import 'package:ajhman/data/model/add_comment_response_model.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/data/repository/comments_repository.dart';
import 'package:ajhman/data/shared_preferences/profile_data.dart';
import 'package:ajhman/main.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../enum/state_status.dart';

part 'comments_event.dart';

part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentInitial()) {
    on<CommentsEvent>((event, emit) async {
      if (event is GetComments) {
        emit(CommentLoading());

        try {
          List<CommentsResponseModel> response = await commentsRepository
              .getComments(event.chapterId, event.subChapterId);

          if (response.isEmpty) {
            emit(CommentEmpty());
          } else {
            emit(CommentSuccess(response: response));
          }
        } on DioError catch (e) {
          emit(CommentFail());
        }
      }

      if (event is PostComments) {
        try {
          final profile = await getProfile();
          CommentsResponseModel response = await commentsRepository.addComment(
              event.chapterId, event.subChapterId, event.request);
          response.likes = 0;
          response.dislikes = 0;
          response.userFeedback = null;
          response.userFeedback = null;
          response.user = User(id: profile.id,name: profile.name,image: profile.image);
          event.data.insert(0, response);
          emit(CommentSuccess(response: event.data));
        } on DioError catch (e) {
          emit(CommentAddFail(response: event.data));
        }
      }

      if (event is ChangeComment) {
        try {

           await commentsRepository.putFeed(
              event.chapterId, event.subChapterId, event.comment.id!,event.comment.userFeedback);

          for (var element in event.data) {
            if(element.id == event.comment.id){
              element = event.comment;
              break;
            }
            if(element.replies != null){
              for (var element in element.replies!) {
                if(element.id == event.comment.id){
                  element = event.comment;
                  break;

                }
              }
            }
          }
          emit(CommentSuccess(response: event.data));
        } on DioError catch (e) {
          emit(CommentChangeFail(response: event.data));

        }
      }
    });
  }
}
