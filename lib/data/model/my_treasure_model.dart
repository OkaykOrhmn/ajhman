class MyTreasureModel {
  List<Gold>? gold;
  List<Gold>? silver;
  List<Gold>? bronze;

  MyTreasureModel({this.gold, this.silver, this.bronze});

  MyTreasureModel.fromJson(Map<String, dynamic> json) {
    if (json['gold'] != null) {
      gold = <Gold>[];
      json['gold'].forEach((v) {
        gold!.add(new Gold.fromJson(v));
      });
    }
    if (json['silver'] != null) {
      silver = <Gold>[];
      json['silver'].forEach((v) {
        silver!.add(new Gold.fromJson(v));
      });
    }
    if (json['bronze'] != null) {
      bronze = <Gold>[];
      json['bronze'].forEach((v) {
        bronze!.add(new Gold.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gold != null) {
      data['gold'] = this.gold!.map((v) => v.toJson()).toList();
    }
    if (this.silver != null) {
      data['silver'] = this.silver!.map((v) => v.toJson()).toList();
    }
    if (this.bronze != null) {
      data['bronze'] = this.bronze!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['score'] = this.score;
    return data;
  }
}