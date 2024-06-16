import 'package:ajhman/data/args/course_args.dart';
import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/data/repository/chapter_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../enum/state_status.dart';

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
        } on DioError catch (e) {
          emit(ChapterFail());
        }
      }
    });
  }
}
