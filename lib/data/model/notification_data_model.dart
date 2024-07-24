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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['image'] = image;
    return data;
  }
}
