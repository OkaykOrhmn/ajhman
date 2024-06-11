import 'package:ajhman/core/enum/course_types.dart';

class CourseArgs {
  int? chapterId;
  String? chapterTitle;
  int? subChapterId;
  List<int>? ids;

  CourseArgs(this.chapterId, this.chapterTitle, this.subChapterId, this.ids);

  CourseArgs copyWith({
    int? chapterId,
    String? chapterTitle,
    int? subChapterId,
    List<int>? ids,
  }) {
    return CourseArgs(
      chapterId ?? this.chapterId,
      chapterTitle ?? this.chapterTitle,
      subChapterId ?? this.subChapterId,
      ids ?? this.ids,
    );
  }

  CourseArgs.fromJson(Map<String, dynamic> json) {
    chapterId = json['courseId'];
    chapterTitle = json['chapterTitle'];
    subChapterId = json['subChapterId'];
    ids = json['ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapterId'] = this.chapterId;
    data['chapterTitle'] = this.chapterTitle;
    data['subChapterId'] = this.subChapterId;
    data['ids'] = this.ids;
    return data;
  }
}
