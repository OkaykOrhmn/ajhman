import 'package:ajhman/data/model/feedbacks_questions_model.dart';
import 'package:ajhman/data/model/questions_model.dart';
import 'package:ajhman/data/repository/questions_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

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
        } on DioError catch (e) {
          emit(QuestionsFail());
        }
      }

      if (event is PutQuestions) {
        try {
          await questionsRepository.putQuestions(
              event.id, event.feedbacksQuestionsModel);
          emit(QuestionsSuccess(questionsModel: event.questionsModel));
        } on DioError catch (e) {
          emit(QuestionsFail());
        }
      }
    });
  }
}
