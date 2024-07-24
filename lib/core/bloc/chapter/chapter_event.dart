part of 'chapter_bloc.dart';

@immutable
sealed class ChapterEvent {}

class GetInfoChapter extends ChapterEvent{
  final int chapterId;
  final int subChapterId;

  GetInfoChapter({required this.chapterId, required this.subChapterId});

}

