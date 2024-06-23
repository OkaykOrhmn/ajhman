class NewCourseCardModel {
  int? id;
  String? name;
  int? level;
  String? image;
  String? type;
  Category? category;
  int? time;
  int? users;
  int? score;
  bool? marked;
  String? progress;
  String? status;
  String? expiresAt;
  bool? canStart;
  bool? registered;
  String? tag;
  String? audio;
  String? writer;
  int? pages;
  String? publisher;
  String? topic;

  NewCourseCardModel({
    this.id,
    this.name,
    this.level,
    this.image,
    this.type,
    this.category,
    this.time,
    this.score,
    this.users,
    this.marked,
    this.progress,
    this.status,
    this.expiresAt,
    this.canStart,
    this.registered,
    this.tag,
    this.audio,
    this.writer,
    this.pages,
    this.publisher,
    this.topic,
  });

  NewCourseCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    image = json['image'];
    type = json['type'];
    category = json['Category'] != null
        ? new Category.fromJson(json['Category'])
        : null;
    time = json['time'];
    users = json['users'];
    score = json['score'];
    marked = json['marked'];
    progress = json['progress'];
    status = json['status'];
    expiresAt = json['expiresAt'];
    registered = json['registered'];
    tag = json['tag'];
    audio = json['audio'];
    writer = json['writer'];
    pages = json['pages'];
    publisher = json['publisher'];
    topic = json['topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    data['image'] = this.image;
    data['type'] = this.type;
    if (this.category != null) {
      data['Category'] = this.category!.toJson();
    }
    data['time'] = this.time;
    data['users'] = this.users;
    data['score'] = this.score;
    data['marked'] = this.marked;
    data['progress'] = this.progress;
    data['status'] = this.status;
    data['expiresAt'] = this.expiresAt;
    data['registered'] = this.registered;
    data['tag'] = this.tag;
    data['audio'] = this.audio;
    data['writer'] = this.writer;
    data['pages'] = this.pages;
    data['publisher'] = this.publisher;
    data['topic'] = this.topic;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.name, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
