class AnswerRequestModel {
  List<Answers>? answers;
  String? comment;

  AnswerRequestModel({this.answers, this.comment});

  AnswerRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['comment'] = comment;
    return data;
  }
}

class Answers {
  int? questionId;
  int? answer;

  Answers({this.questionId, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['answer'] = answer;
    return data;
  }
}
