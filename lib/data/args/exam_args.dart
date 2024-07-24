import '../model/exam_response_model.dart';

class ExamArgs {
  final ExamResponseModel model;
  final String comment;
  final int courseId;

  ExamArgs(
      {required this.model, required this.comment, required this.courseId});
}
