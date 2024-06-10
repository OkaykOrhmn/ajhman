class CourseMainArgs {
  int? courseId;

  CourseMainArgs({this.courseId});

  CourseMainArgs.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    return data;
  }
}