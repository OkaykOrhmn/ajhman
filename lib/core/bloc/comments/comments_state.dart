part of 'comments_bloc.dart';

@immutable
enum CommentStatus {
  init,
  loading,
  changeStatus,
  success,
  fail,
  loaded,
  addComment
}

class CommentsState {}

class CommentInitial extends CommentsState {}

class CommentLoading extends CommentsState {}

class CommentEmpty extends CommentsState {}

class CommentChange extends CommentsState {
  final List<CommentsResponseModel> response;

  CommentChange({required this.response});

}
class CommentChangeFail extends CommentsState {
  final List<CommentsResponseModel> response;

  CommentChangeFail({required this.response});

}

class CommentAdd extends CommentsState {}

class CommentAddFail extends CommentsState {
  final List<CommentsResponseModel> response;

  CommentAddFail({required this.response});
}

class CommentSuccess extends CommentsState {
  final List<CommentsResponseModel> response;

  CommentSuccess({required this.response});
}

class CommentFail extends CommentsState {}
