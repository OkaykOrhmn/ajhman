import 'package:ajhman/data/model/answer_request_model.dart';
import 'package:bloc/bloc.dart';

class AnswerCubit extends Cubit<AnswerModel> {
  AnswerCubit()
      : super(AnswerModel(
            answerRequestModel: AnswerRequestModel(answers: [],comment: ""), index: 0));

  Future<void> changeAnswer(Answers? answers) async{
    List<Answers> mainAnswers = state.answerRequestModel.answers!;
    if (answers != null) {
      bool change = false;
      for (var element in mainAnswers) {
        if (element.questionId == answers.questionId) {
          int indx = mainAnswers.indexOf(element);
          mainAnswers[indx] = answers;
          change = true;
        }
      }
      if (!change) {
        mainAnswers.add(answers);
      }
    }
    emit(AnswerModel(
        answerRequestModel: AnswerRequestModel(answers: mainAnswers),
        index: state.index));
  }

  void changeIndex(int index) {
    emit(AnswerModel(
        answerRequestModel: state.answerRequestModel, index: index));
  }


}

class AnswerModel {
  final AnswerRequestModel answerRequestModel;
  final int index;

  AnswerModel({required this.answerRequestModel, required this.index});
}
