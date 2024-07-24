class SummaryModel {
  List<String>? summary;

  SummaryModel({this.summary});

  SummaryModel.fromJson(Map<String, dynamic> json) {
    summary = json['summary'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['summary'] = summary;
    return data;
  }
}
