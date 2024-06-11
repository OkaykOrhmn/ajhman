class QuestionsModel {
  List<Questions>? questions;

  QuestionsModel({this.questions});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['Questions'] != null) {
      questions = <Questions>[];
      json['Questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['Questions'] = this.questions!.map((v) => v.toJson()).toList();
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
    question = json['Question'] != null
        ? new Question.fromJson(json['Question'])
        : null;
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.question != null) {
      data['Question'] = this.question!.toJson();
    }
    data['score'] = this.score;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}