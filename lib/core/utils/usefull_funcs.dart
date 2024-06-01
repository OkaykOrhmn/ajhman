import 'package:ajhman/core/enum/levels.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';

import '../enum/course_types.dart';

String getLevel(int? level) => Levels.values[level!].value;

CourseTypes getType(String? type) {
  CourseTypes result = CourseTypes.text;
  if (type == CourseTypes.text.type) {
    result = CourseTypes.text;
  } else if (type == CourseTypes.video.type) {
    result = CourseTypes.video;
  } else if (type == CourseTypes.image.type) {
    result = CourseTypes.image;
  } else if (type == CourseTypes.audio.type) {
    result = CourseTypes.audio;
  }
  return result;
}

String getTypeImage(int? level) => Levels.values[level!].value;

String getImageUrl(String? image) => ApiEndPoints.baseURL + image!;

String getChapterNumber(int index, List<Chapters?> chapters) {
  final list = [
    "اول",
    "دوم",
    "سوم",
    "چهارم",
    "پنجم",
    "ششم",
    "هفتم",
    "هشتم",
    "نهم",
    "دهم",
  ];
  String result = "";
  if (index == chapters.length - 1 && chapters.length > 1) {
    result = "آخر";
  } else if (index <= list.length) {
    result = list[index];
  }
  return result;
}