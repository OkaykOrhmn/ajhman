class CourseMainResponseModel {
  int? id;
  String? name;
  int? level;
  String? image;
  List<String>? highlight;
  String? description;
  List<Chapters>? chapters;
  Category? category;

  CourseMainResponseModel(
      {this.id,
        this.name,
        this.level,
        this.image,
        this.highlight,
        this.description,
        this.chapters,
        this.category});

  CourseMainResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    image = json['image'];
    highlight = json['highlight'].cast<String>();
    description = json['description'];
    if (json['Chapters'] != null) {
      chapters = <Chapters>[];
      json['Chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
    category = json['Category'] != null
        ? new Category.fromJson(json['Category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level'] = this.level;
    data['image'] = this.image;
    data['highlight'] = this.highlight;
    data['description'] = this.description;
    if (this.chapters != null) {
      data['Chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['Category'] = this.category!.toJson();
    }
    return data;
  }
}

class Chapters {
  int? id;
  String? name;
  int? score;
  List<Subchapters>? subchapters;
  bool? isOpen;

  Chapters({this.id, this.name, this.score, this.subchapters, this.isOpen});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    score = json['score'];
    if (json['Subchapters'] != null) {
      subchapters = <Subchapters>[];
      json['Subchapters'].forEach((v) {
        subchapters!.add(new Subchapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['score'] = this.score;
    if (this.subchapters != null) {
      data['Subchapters'] = this.subchapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subchapters {
  int? id;
  String? type;
  String? name;

  Subchapters({this.id, this.type, this.name});

  Subchapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    return data;
  }
}

class Category {
  String? name;

  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}