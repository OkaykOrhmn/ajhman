class AnswerRequestModel {
  List<Answers>? answers;
  String? comment;

  AnswerRequestModel({this.answers, this.comment});

  AnswerRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['comment'] = this.comment;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['answer'] = this.answer;
    return data;
  }
}