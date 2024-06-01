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
  final int id;
  final CommentType type;
  final bool? feed;

  ChangeFeedComment(
      {required this.chapter,
      required this.subChapter,
      required this.id,
      required this.type,
      required this.feed});
}
