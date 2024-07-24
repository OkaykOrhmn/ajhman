class FeedbackResponseModel {
  List<CommentsFeedback>? commentsFeedback;

  FeedbackResponseModel({this.commentsFeedback});

  FeedbackResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['CommentsFeedback'] != null) {
      commentsFeedback = <CommentsFeedback>[];
      json['CommentsFeedback'].forEach((v) {
        commentsFeedback!.add(CommentsFeedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commentsFeedback != null) {
      data['CommentsFeedback'] =
          commentsFeedback!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['liked'] = liked;
    return data;
  }
}
