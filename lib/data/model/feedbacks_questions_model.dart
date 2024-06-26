class FeedbacksQuestionsModel {
  List<Feedbacks>? feedbacks;

  FeedbacksQuestionsModel({this.feedbacks});

  FeedbacksQuestionsModel.fromJson(Map<String, dynamic> json) {
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(Feedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feedbacks != null) {
      data['feedbacks'] = feedbacks!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['score'] = score;
    return data;
  }
}
