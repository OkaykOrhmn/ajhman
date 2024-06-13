class SummaryModel {
  List<String>? summary;

  SummaryModel({this.summary});

  SummaryModel.fromJson(Map<String, dynamic> json) {
    summary = json['summary'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary'] = this.summary;
    return data;
  }
}