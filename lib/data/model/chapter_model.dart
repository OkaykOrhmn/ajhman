class ChapterModel {
  int? id;
  String? name;
  String? description;
  List<String>? highlight;
  String? type;
  List<Media>? media;

  ChapterModel(
      {this.id,
        this.name,
        this.description,
        this.highlight,
        this.type,
        this.media});

  ChapterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    highlight = json['highlight'].cast<String>();
    type = json['type'];
    if (json['Media'] != null) {
      media = <Media>[];
      json['Media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['highlight'] = this.highlight;
    data['type'] = this.type;
    if (this.media != null) {
      data['Media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int? id;
  String? source;
  String? type;
  int? subchapterId;

  Media({this.id, this.source, this.type, this.subchapterId});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source = json['source'];
    type = json['type'];
    subchapterId = json['subchapterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['source'] = this.source;
    data['type'] = this.type;
    data['subchapterId'] = this.subchapterId;
    return data;
  }
}