part of 'comments_bloc.dart';

@immutable
enum CommentStatus { init, loading, changeStatus, success, fail, loaded,addComment }

class CommentsState extends Equatable {
  final CommentStatus status;
  final String type;
  final dynamic data;
  final int? commentId;

  const CommentsState({
    this.status = CommentStatus.loading,
    this.type = '',
    this.data,
    this.commentId,
  });

  CommentsState copyWith(
      {CommentStatus? status, String? type, dynamic data, int? commentId}) {
    return CommentsState(
        status: status ?? this.status,
        type: type ?? this.type,
        data: data ?? this.data,
        commentId: commentId ?? this.commentId);
  }

  @override
  List<Object> get props => [status, type];
}
