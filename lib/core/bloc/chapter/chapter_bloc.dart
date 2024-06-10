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
  ChapterBloc() : super(const ChapterState()) {
    on<ChapterEvent>((event, emit) async {
      if (event is GetInfoChapter) {
        emit(const ChapterState(status: ChapterStateStatus.loading));
        try {
          ChapterModel response = await chapterRepository.getChapter(
              event.args.chapterId!, event.args.subChapterId!);
          emit(ChapterState(status: ChapterStateStatus.success,data: response));
        } on DioError catch (e) {
          emit(const ChapterState(status: ChapterStateStatus.fail,data: null));
        }
      }
    });
  }
}
