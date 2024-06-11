class FeedbacksQuestionsModel {
  List<Feedbacks>? feedbacks;

  FeedbacksQuestionsModel({this.feedbacks});

  FeedbacksQuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new Feedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedbacks {
  int? questionId;
  int? score;

  Feedbacks({this.questionId, this.score});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['score'] = this.score;
    return data;
  }
}
