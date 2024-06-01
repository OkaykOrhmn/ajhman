import 'package:ajhman/core/enum/comment.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/data/repository/comments_repository.dart';
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
              status: StateStatus.success,
              type: ApiEndPoints.comment,
              data: response);
          emit(result);
        } on DioError catch (e) {
          result = CommentsState(
              status: StateStatus.fail,
              type: ApiEndPoints.comment,
              data: e.response!.data);
          emit(result);
        }
      }
      if (event is ChangeFeedComment) {
        List<CommentsResponseModel> responseModel = state.data;
        emit(result.copyWith(
            status: StateStatus.changeStatus, type: '', data: responseModel));

        late bool success;

        try {
          await commentsRepository.putFeed(
              event.chapter, event.subChapter, event.id, event.feed);
          success = true;
        } on DioError catch (e) {
          success = false;
        }

        if (success) {
          responseModel.forEach((element) {
            if (event.type == CommentType.reply) {
              element.replies!.forEach((element) {
                if (element.id == event.id) {
                  element.userFeedback = event.feed;
                }
              });
            } else {
              if (element.id == event.id) {
                element.userFeedback = event.feed;
              }
            }
          });
        }

        emit(result.copyWith(
            status: StateStatus.success, type: '', data: responseModel));
      }
    });
  }
}
