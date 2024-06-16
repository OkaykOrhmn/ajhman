part of 'feed_comment_cubit.dart';

@immutable
sealed class FeedCommentState {}

final class FeedCommentInitial extends FeedCommentState {}
final class FeedCommentLoading extends FeedCommentState {}
final class FeedCommentSuccess extends FeedCommentState {}
final class FeedCommentFail extends FeedCommentState {}
