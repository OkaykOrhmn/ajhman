class LeaderboardModel {
  List<User>? users;
  User? user;

  LeaderboardModel({this.users, this.user});

  LeaderboardModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Users {
  String? name;
  String? image;
  bool? current;
  int? score;
  String? submitedAt;
  int? licenses;
  int? courses;

  Users(
      {this.name,
        this.image,
        this.current,
        this.score,
        this.submitedAt,
        this.licenses,
        this.courses});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    current = json['current'];
    score = json['score'];
    submitedAt = json['submitedAt'];
    licenses = json['licenses'];
    courses = json['courses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['current'] = this.current;
    data['score'] = this.score;
    data['submitedAt'] = this.submitedAt;
    data['licenses'] = this.licenses;
    data['courses'] = this.courses;
    return data;
  }
}

class User {
  String? name;
  String? image;
  List<ExamAnswer>? examAnswer;
  int? score;
  int? licenses;
  int? courses;
  int? rating;

  bool? current;
  String? submitedAt;

  User(
      {this.name,
        this.image,
        this.examAnswer,
        this.score,
        this.licenses,
        this.courses,
        this.current,
        this.submitedAt,
        this.rating});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    if (json['ExamAnswer'] != null) {
      examAnswer = <ExamAnswer>[];
      json['ExamAnswer'].forEach((v) {
        examAnswer!.add(new ExamAnswer.fromJson(v));
      });
    }
    score = json['score'];
    licenses = json['licenses'];
    courses = json['courses'];
    current = json['current'];
    submitedAt = json['submitedAt'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.examAnswer != null) {
      data['ExamAnswer'] = this.examAnswer!.map((v) => v.toJson()).toList();
    }
    data['score'] = this.score;
    data['licenses'] = this.licenses;
    data['courses'] = this.courses;
    data['rating'] = this.rating;
    data['current'] = this.current;
    data['submitedAt'] = this.submitedAt;
    return data;
  }
}

class ExamAnswer {
  String? createdAt;
  int? score;

  ExamAnswer({this.createdAt, this.score});

  ExamAnswer.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['score'] = this.score;
    return data;
  }
}