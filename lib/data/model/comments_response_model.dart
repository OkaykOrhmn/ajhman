
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
    replyUser = json['replyUser'] != null ? User.fromJson(json['replyUser']) : null;
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

// class Replies {
//   int? id;
//   String? text;
//   String? resource;
//   String? createdAt;
//   User? user;
//   User? replyUser;
//   int? likes;
//   int? dislikes;
//   bool? userFeedback;
//
//   Replies(
//       {this.id,
//         this.text,
//         this.resource,
//         this.createdAt,
//         this.user,
//         this.replyUser,
//         this.likes,
//         this.dislikes,
//         this.userFeedback});
//
//   Replies.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     text = json['text'];
//     resource = json['resource'];
//     createdAt = json['createdAt'];
//     user = json['User'] != null ? new User.fromJson(json['User']) : null;
//     replyUser =
//     json['replyUser'] != null ? new User.fromJson(json['replyUser']) : null;
//     likes = json['likes'];
//     dislikes = json['dislikes'];
//     userFeedback = json['UserFeedback'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['text'] = this.text;
//     data['resource'] = this.resource;
//     data['createdAt'] = this.createdAt;
//     if (this.user != null) {
//       data['User'] = this.user!.toJson();
//     }
//     if (this.replyUser != null) {
//       data['replyUser'] = this.replyUser!.toJson();
//     }
//     data['likes'] = this.likes;
//     data['dislikes'] = this.dislikes;
//     data['UserFeedback'] = this.userFeedback;
//     return data;
//   }
// }

// class Comment {
//   int? id;
//   int? indexC;
//   int? indexR;
//   String? text;
//   String? resource;
//   String? createdAt;
//   User? user;
//   User? userReply;
//   int? likes;
//   int? dislikes;
//   int? replies;
//   bool? userFeedback;
//   CommentType? commentType;
//
//
//   Comment(this.id,this.indexC,this.indexR, this.text, this.resource, this.createdAt, this.user,
//       this.likes, this.dislikes, this.replies, this.userFeedback);
//
//   Comment.setCommentNormal(CommentsResponseModel comment, int index) {
//     id = comment.id;
//     indexC = index;
//     text = comment.text;
//     resource = comment.resource;
//     createdAt = comment.createdAt;
//     user = comment.user;
//     likes = comment.likes;
//     dislikes = comment.dislikes;
//     replies = comment.replies!.length;
//     userFeedback = comment.userFeedback;
//     commentType = CommentType.normal;
//   }
//
//   Comment.setCommentOwn(CommentsResponseModel comment, int index) {
//     id = comment.id;
//     text = comment.text;
//   indexC = index;
//   resource = comment.resource;
//     createdAt = comment.createdAt;
//     user = comment.user;
//     likes = comment.likes;
//     dislikes = comment.dislikes;
//     replies = comment.replies!.length;
//     userFeedback = comment.userFeedback;
//     commentType = CommentType.normal;
//   }
//
//   Comment.setReply(Replies comment, int indexC, int indexR) {
//     id = comment.id;
//     indexC = indexC;
//     indexR = indexR;
//     text = comment.text;
//     createdAt = comment.createdAt;
//     user = comment.user;
//     userReply = comment.replyUser;
//     likes = comment.likes;
//     dislikes = comment.dislikes;
//     replies = 0;
//     userFeedback = comment.userFeedback;
//     commentType = CommentType.reply;
//
//   }
// }
