class CourseMainArgs {
  int? courseId;

  CourseMainArgs({this.courseId});

  CourseMainArgs.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseId'] = courseId;
    return data;
  }
}