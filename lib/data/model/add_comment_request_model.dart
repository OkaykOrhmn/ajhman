class AddCommentRequestModel {
  String? text;
  String? resource;
  int? commentId;
  String? replyUserId;

  AddCommentRequestModel(
      {this.text, this.resource, this.commentId, this.replyUserId});

  AddCommentRequestModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    resource = json['resource'];
    commentId = json['commentId'];
    replyUserId = json['replyUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['resource'] = this.resource;
    data['commentId'] = this.commentId;
    data['replyUserId'] = this.replyUserId;
    return data;
  }
}