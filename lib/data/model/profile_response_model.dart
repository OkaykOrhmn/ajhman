class ProfileResponseModel {
  String? id;
  String? name;
  String? mobileNumber;

  ProfileResponseModel({this.id, this.name, this.mobileNumber});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}