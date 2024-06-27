class NotificationDataModel {
  String? title;
  String? body;
  String? image;

  NotificationDataModel({this.title, this.body, this.image});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['image'] = this.image;
    return data;
  }
}