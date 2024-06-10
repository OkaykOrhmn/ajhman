part of 'chapter_bloc.dart';

@immutable
sealed class ChapterEvent {}

class GetInfoChapter extends ChapterEvent{
  final CourseArgs args;

  GetInfoChapter({required this.args});

}
