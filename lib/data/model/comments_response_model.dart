class CommentsResponseModel {
  int? id;
  String? text;
  String? resource;
  String? createdAt;
  User? user;
  List<CommentsResponseModel>? replies;
  int? likes;
  int? dislikes;
  bool? userFeedback;
  User? replyUser;

  int? commentId;
  String? userId;

  CommentsResponseModel(
      {this.id,
      this.text,
      this.resource,
      this.createdAt,
      this.user,
      this.replies,
      this.likes,
      this.dislikes,
      this.replyUser,
      this.userFeedback});

  CommentsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    resource = json['resource'];
    createdAt = json['createdAt'];
    user = json['User'] != null ? User.fromJson(json['User']) : null;
    replyUser =
        json['replyUser'] != null ? User.fromJson(json['replyUser']) : null;
    if (json['Replies'] != null) {
      replies = <CommentsResponseModel>[];
      json['Replies'].forEach((v) {
        replies!.add(CommentsResponseModel.fromJson(v));
      });
    }
    likes = json['likes'];
    dislikes = json['dislikes'];
    userFeedback = json['UserFeedback'];
    userId = json['userId'];
    commentId = json['commentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['resource'] = resource;
    data['createdAt'] = createdAt;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    if (replies != null) {
      data['Replies'] = replies!.map((v) => v.toJson()).toList();
    }
    data['likes'] = likes;
    data['dislikes'] = dislikes;
    data['UserFeedback'] = userFeedback;
    data['replyUser'] = replyUser;
    data['userId'] = userId;
    data['commentId'] = commentId;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
