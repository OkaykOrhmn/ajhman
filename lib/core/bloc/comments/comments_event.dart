part of 'comments_bloc.dart';

@immutable
sealed class CommentsEvent {}

class GetComments extends CommentsEvent {
  final int chapter;
  final int subChapter;

  GetComments({required this.chapter, required this.subChapter});
}

class ChangeFeedComment extends CommentsEvent {
  final int chapter;
  final int subChapter;
  final dynamic comment;
  final CommentType commentType;

  ChangeFeedComment({required this.chapter, required this.subChapter, required this.comment,required this.commentType});



}
class AddComment extends CommentsEvent{
  final int chapter;
  final int subChapter;
  final AddCommentRequestModel comment;

  AddComment({required this.chapter, required this.subChapter, required this.comment});
}
