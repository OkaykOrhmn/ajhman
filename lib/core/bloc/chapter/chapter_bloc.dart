// ignore_for_file: deprecated_member_use
import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/data/repository/chapter_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chapter_event.dart';
part 'chapter_state.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  ChapterBloc() : super(ChapterInitial()) {
    on<ChapterEvent>((event, emit) async {
      if (event is GetInfoChapter) {
        emit(ChapterLoading());
        try {
          ChapterModel response = await chapterRepository.getChapter(
              event.chapterId, event.subChapterId);
          emit(ChapterSuccess(response: response));
        } on DioError {
          emit(ChapterFail());
        }
      }
    });
  }
}
