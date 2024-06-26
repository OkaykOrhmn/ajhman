class CourseMainResponseModel {
  int? id;
  String? name;
  int? level;
  int? time;
  int? users;
  String? image;
  List<String>? highlight;
  String? description;
  List<courseMainChapters>? chapters;
  Category? category;
  bool? registered;
  int? examScore;
  String? tag;
  String? audio;
  String? writer;
  int? pages;
  String? publisher;
  String? topic;

  CourseMainResponseModel(
      {this.id,
      this.name,
      this.level,
      this.time,
      this.users,
      this.image,
      this.highlight,
      this.description,
      this.chapters,
      this.registered,
      this.examScore,
      this.tag,
      this.audio,
      this.writer,
      this.pages,
      this.publisher,
      this.topic,
      this.category});

  CourseMainResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    time = json['time'];
    users = json['users'];
    image = json['image'];
    highlight = json['highlight'].cast<String>();
    description = json['description'];
    registered = json['registered'];
    examScore = json['examScore'];
    tag = json['tag'];
    audio = json['audio'];
    writer = json['writer'];
    pages = json['pages'];
    publisher = json['publisher'];
    topic = json['topic'];
    if (json['Chapters'] != null) {
      chapters = <courseMainChapters>[];
      json['Chapters'].forEach((v) {
        chapters!.add(courseMainChapters.fromJson(v));
      });
    }
    category = json['Category'] != null
        ? Category.fromJson(json['Category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['level'] = level;
    data['time'] = time;
    data['users'] = users;
    data['image'] = image;
    data['highlight'] = highlight;
    data['description'] = description;
    data['registered'] = registered;
    data['examScore'] = examScore;
    data['tag'] = tag;
    data['audio'] = audio;
    data['writer'] = writer;
    data['pages'] = pages;
    data['publisher'] = publisher;
    data['topic'] = topic;
    if (chapters != null) {
      data['Chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['Category'] = category!.toJson();
    }
    return data;
  }
}

class courseMainChapters {
  int? id;
  String? name;
  int? score;
  int? time;
  List<Subchapters>? subchapters;
  bool? isOpen = false;

  courseMainChapters({this.id, this.name, this.score, this.subchapters});

  courseMainChapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    score = json['score'];
    time = json['time'];
    if (json['Subchapters'] != null) {
      subchapters = <Subchapters>[];
      json['Subchapters'].forEach((v) {
        subchapters!.add(Subchapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['score'] = score;
    data['time'] = time;
    if (subchapters != null) {
      data['Subchapters'] = subchapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subchapters {
  int? id;
  String? type;
  String? name;
  bool? visited;

  Subchapters({this.id, this.type, this.name, this.visited});

  Subchapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    visited = json['visited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['visited'] = visited;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
