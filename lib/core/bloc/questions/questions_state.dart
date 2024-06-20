part of 'questions_bloc.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}
final class QuestionsLoading extends QuestionsState {}
final class QuestionsSuccess extends QuestionsState {
  final QuestionsModel questionsModel;

  QuestionsSuccess({required this.questionsModel});


}
final class QuestionsFail extends QuestionsState {}
final class QuestionsPutFail extends QuestionsState {
  final QuestionsModel questionsModel;

  QuestionsPutFail({required this.questionsModel});

}
