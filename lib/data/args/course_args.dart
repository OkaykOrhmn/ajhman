import 'package:ajhman/core/enum/course_types.dart';

class CourseArgs {
  int? chapterId;
  String? chapterTitle;
  int? subChapterId;
  CourseTypes? courseType;

  CourseArgs(this.chapterId, this.chapterTitle,this.subChapterId, this.courseType);

  CourseArgs.fromJson(Map<String, dynamic> json) {
    chapterId = json['courseId'];
    chapterTitle = json['chapterTitle'];
    subChapterId = json['subChapterId'];
    courseType = json['courseType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapterId'] = this.chapterId;
    data['chapterTitle'] = this.chapterTitle;
    data['subChapterId'] = this.subChapterId;
    data['courseType'] = this.courseType;
    return data;
  }
}
