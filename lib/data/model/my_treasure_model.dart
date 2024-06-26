class MyTreasureModel {
  List<Gold>? gold;
  List<Gold>? silver;
  List<Gold>? bronze;

  MyTreasureModel({this.gold, this.silver, this.bronze});

  MyTreasureModel.fromJson(Map<String, dynamic> json) {
    if (json['gold'] != null) {
      gold = <Gold>[];
      json['gold'].forEach((v) {
        gold!.add(Gold.fromJson(v));
      });
    }
    if (json['silver'] != null) {
      silver = <Gold>[];
      json['silver'].forEach((v) {
        silver!.add(Gold.fromJson(v));
      });
    }
    if (json['bronze'] != null) {
      bronze = <Gold>[];
      json['bronze'].forEach((v) {
        bronze!.add(Gold.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gold != null) {
      data['gold'] = gold!.map((v) => v.toJson()).toList();
    }
    if (silver != null) {
      data['silver'] = silver!.map((v) => v.toJson()).toList();
    }
    if (bronze != null) {
      data['bronze'] = bronze!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gold {
  int? id;
  String? name;
  String? image;
  int? score;

  Gold({this.id, this.name, this.image, this.score});

  Gold.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['score'] = score;
    return data;
  }
}