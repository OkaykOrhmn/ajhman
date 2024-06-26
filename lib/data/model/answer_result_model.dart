class AnswerResultModel {
  int? correct;
  int? incorrect;
  int? noAnswer;
  int? total;

  AnswerResultModel({this.correct, this.incorrect, this.noAnswer, this.total});

  AnswerResultModel.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    noAnswer = json['noAnswer'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['correct'] = correct;
    data['incorrect'] = incorrect;
    data['noAnswer'] = noAnswer;
    data['total'] = total;
    return data;
  }
}