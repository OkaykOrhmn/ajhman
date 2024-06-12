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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['noAnswer'] = this.noAnswer;
    data['total'] = this.total;
    return data;
  }
}