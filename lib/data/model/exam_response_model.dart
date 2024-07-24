class ExamResponseModel {
  List<Exam>? exam;

  ExamResponseModel({this.exam});

  ExamResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Exam'] != null) {
      exam = <Exam>[];
      json['Exam'].forEach((v) {
        exam!.add(Exam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (exam != null) {
      data['Exam'] = exam!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exam {
  int? id;
  String? text;
  List<String>? options;

  Exam({this.id, this.text, this.options});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['options'] = options;
    return data;
  }
}
