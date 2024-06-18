import 'package:ajhman/core/enum/course_types.dart';

import '../model/chapter_model.dart';
import '../model/course_main_response_model.dart';

class CourseArgs {
  final CourseMainResponseModel courseData;
   ChapterModel chapterModel;
  final int chapterId;

  CourseArgs( {required this.chapterId,required this.courseData, required this.chapterModel});
}
