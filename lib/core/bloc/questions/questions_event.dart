part of 'questions_bloc.dart';

@immutable
sealed class QuestionsEvent {}

class GetAllQuestions extends QuestionsEvent{
  final int id;

  GetAllQuestions({required this.id});
}
class PutQuestions extends QuestionsEvent{
  final int id;
  final FeedbacksQuestionsModel feedbacksQuestionsModel;
  final QuestionsModel questionsModel;

  PutQuestions({required this.id, required this.feedbacksQuestionsModel, required this.questionsModel});


}
