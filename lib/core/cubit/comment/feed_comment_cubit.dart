import 'dart:core';

import 'package:ajhman/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/comments_response_model.dart';
import '../../../data/repository/comments_repository.dart';
import '../../bloc/comments/comments_bloc.dart';

part 'feed_comment_state.dart';

class FeedCommentCubit extends Cubit<FeedCommentState> {
  final List<CommentsResponseModel> list;
  final int chapterId;
  final int subChapterId;

  FeedCommentCubit(this.list, this.chapterId, this.subChapterId)
      : super(FeedCommentInitial());

  void changeFeed(bool? f, CommentsResponseModel data) {
    emit(FeedCommentLoading());
    if (f == null) {
      if (data.userFeedback != null) {
        if (data.userFeedback!) {
          data.likes = data.likes! - 1;
        } else {
          data.dislikes = data.dislikes! - 1;
        }
      }
    } else if (f) {
      data.likes = data.likes! + 1;
      if (data.userFeedback != null) {
        if (!data.userFeedback!) {
          data.dislikes = data.dislikes! - 1;
        }
      }
    } else {
      data.dislikes = data.dislikes! + 1;
      if (data.userFeedback != null) {
        if (data.userFeedback!) {
          data.likes = data.likes! - 1;
        }
      }
    }

    data.userFeedback = f;
    mContext.read<CommentsBloc>().add(ChangeComment(
        chapterId: 1, subChapterId: 1, data: list, comment: data));
    mContext
        .read<CommentsBloc>()
        .stream
        .firstWhere((element) =>
            element is CommentSuccess || element is CommentChangeFail)
        .then((value) {
      if (value is CommentSuccess) {
        emit(FeedCommentSuccess());
      } else {
        emit(FeedCommentFail());
      }
    });
  }
}
