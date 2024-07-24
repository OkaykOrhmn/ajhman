class RoadmapModel {
  int? id;
  String? name;
  List<Chapters>? chapters;

  RoadmapModel({this.id, this.name, this.chapters});

  RoadmapModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['Chapters'] != null) {
      chapters = <Chapters>[];
      json['Chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (chapters != null) {
      data['Chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  int? id;
  String? name;
  int? percent;

  Chapters({this.id, this.name, this.percent});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['percent'] = percent;
    return data;
  }
}
