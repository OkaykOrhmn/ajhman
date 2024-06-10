import 'package:ajhman/core/enum/levels.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:intl/intl.dart';

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

double daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours).toDouble();
}

double convertDatetimeComment(String createdAt) {
  DateTime createdDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(createdAt);
  DateTime todayDate = DateTime.now();
  return daysBetween(createdDate, todayDate);
}

CourseTypes? getTypeOfCourse(String type){
  for (var element in CourseTypes.values) {
    if(element.type == type){
      return element;
    }
  }
  return null;
}
