part of 'comments_bloc.dart';

@immutable
sealed class CommentsEvent {}

class GetComments extends CommentsEvent{
  final int chapterId;
  final int subChapterId;

  GetComments({required this.chapterId, required this.subChapterId});
}

class PostComments extends CommentsEvent{
  final int chapterId;
  final int subChapterId;
  final AddCommentRequestModel request;
  final List<CommentsResponseModel> data;

  PostComments({required this.chapterId, required this.subChapterId, required this.request, required this.data});


}

class ChangeComment extends CommentsEvent{
  final int chapterId;
  final int subChapterId;
  final List<CommentsResponseModel> data;
  final CommentsResponseModel comment;

  ChangeComment({required this.chapterId, required this.subChapterId, required this.data, required this.comment});







}
