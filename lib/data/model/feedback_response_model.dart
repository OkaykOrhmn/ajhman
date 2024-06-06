class FeedbackResponseModel {
  List<CommentsFeedback>? commentsFeedback;

  FeedbackResponseModel({this.commentsFeedback});

  FeedbackResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['CommentsFeedback'] != null) {
      commentsFeedback = <CommentsFeedback>[];
      json['CommentsFeedback'].forEach((v) {
        commentsFeedback!.add(new CommentsFeedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commentsFeedback != null) {
      data['CommentsFeedback'] =
          this.commentsFeedback!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentsFeedback {
  bool? liked;

  CommentsFeedback({this.liked});

  CommentsFeedback.fromJson(Map<String, dynamic> json) {
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liked'] = this.liked;
    return data;
  }
}