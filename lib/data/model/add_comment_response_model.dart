import 'comments_response_model.dart';

class AddCommentResponseModel {
  int? id;
  String? text;
  String? resource;
  String? createdAt;
  int? commentId;
  String? userId;
  User? replyUser;

  AddCommentResponseModel(
      {this.id,
        this.text,
        this.resource,
        this.createdAt,
        this.commentId,
        this.userId,
        this.replyUser});

  AddCommentResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    resource = json['resource'];
    createdAt = json['createdAt'];
    commentId = json['commentId'];
    userId = json['userId'];
    replyUser = json['replyUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['resource'] = resource;
    data['createdAt'] = createdAt;
    data['commentId'] = commentId;
    data['userId'] = userId;
    data['replyUser'] = replyUser;
    return data;
  }
}