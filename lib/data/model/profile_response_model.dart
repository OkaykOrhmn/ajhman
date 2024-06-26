class ProfileResponseModel {
  String? id;
  String? name;
  String? mobileNumber;
  String? image;

  ProfileResponseModel({this.id, this.name, this.mobileNumber});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobileNumber'] = mobileNumber;
    data['image'] = image;
    return data;
  }
}