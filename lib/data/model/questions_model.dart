class QuestionsModel {
  List<Questions>? questions;

  QuestionsModel({this.questions});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['Questions'] != null) {
      questions = <Questions>[];
      json['Questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['Questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  Question? question;
  int? score;

  Questions({this.id, this.question, this.score});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question =
        json['Question'] != null ? Question.fromJson(json['Question']) : null;
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (question != null) {
      data['Question'] = question!.toJson();
    }
    data['score'] = score;
    return data;
  }
}

class Question {
  String? text;

  Question({this.text});

  Question.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}
