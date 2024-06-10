part of 'chapter_bloc.dart';

enum ChapterStateStatus { init, loading,success,fail }

@immutable
class ChapterState extends Equatable{
  final ChapterStateStatus status;
  final ChapterModel? data;

  const ChapterState({this.status = ChapterStateStatus.init, this.data});

  ChapterState copyWith(
      {required ChapterStateStatus status, ChapterModel? data}) {
    return ChapterState(status: status , data: data ?? this.data);
  }

  @override
  List<Object> get props => [status];
}

