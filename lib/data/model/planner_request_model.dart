class PlannerRequestModel {
  List<int>? days;
  String? startAt;
  int? time;

  PlannerRequestModel({this.days, this.startAt, this.time});

  PlannerRequestModel.fromJson(Map<String, dynamic> json) {
    days = json['days'].cast<int>();
    startAt = json['startAt'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    data['startAt'] = this.startAt;
    data['time'] = this.time;
    return data;
  }
}