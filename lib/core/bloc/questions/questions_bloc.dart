// ignore_for_file: deprecated_member_use

import 'package:ajhman/data/model/feedbacks_questions_model.dart';
import 'package:ajhman/data/model/questions_model.dart';
import 'package:ajhman/data/repository/questions_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc() : super(QuestionsInitial()) {
    on<QuestionsEvent>((event, emit) async {
      if (event is GetAllQuestions) {
        emit(QuestionsLoading());
        try {
          QuestionsModel response =
              await questionsRepository.getQuestions(event.id);

          emit(QuestionsSuccess(questionsModel: response));
        } on DioError {
          emit(QuestionsFail());
        }
      }

      if (event is PutQuestions) {
        try {
          await questionsRepository.putQuestions(
              event.id, event.feedbacksQuestionsModel);
          emit(QuestionsSuccess(questionsModel: event.questionsModel));
        } on DioError {
          emit(QuestionsPutFail(questionsModel: event.questionsModel));
        }
      }
    });
  }
}
