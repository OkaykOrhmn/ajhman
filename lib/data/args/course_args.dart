import '../model/chapter_model.dart';
import '../model/course_main_response_model.dart';

class CourseArgs {
  final CourseMainResponseModel courseData;
  ChapterModel chapterModel;
  final int chapterId;
  final bool isInternational;

  CourseArgs(
      {required this.chapterId,
      required this.courseData,
      required this.chapterModel,
      this.isInternational = false});
}
