class NewCourseCardModel {
  int? id;
  String? name;
  int? level;
  String? image;
  String? type;
  Category? category;
  int? time;
  int? users;
  bool? marked;

  NewCourseCardModel(
      {this.id,
        this.name,
        this.level,
        this.image,
        this.type,
        this.category,
        this.time,
        this.users,
        this.marked,
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
    marked = json['marked'];
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
    data['marked'] = this.marked;
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