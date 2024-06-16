part of 'chapter_bloc.dart';


@immutable
class ChapterState {}
class ChapterInitial extends ChapterState {}
class ChapterLoading extends ChapterState {}
class ChapterSuccess extends ChapterState {
  final ChapterModel response;

  ChapterSuccess({required this.response});
}
class ChapterFail extends ChapterState {}

