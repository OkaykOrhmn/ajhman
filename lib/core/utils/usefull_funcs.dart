import 'dart:math';
import 'dart:ui';

import 'package:ajhman/core/enum/levels.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/data/model/roadmap_view.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../gen/assets.gen.dart';
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

String getImageUrl(String? image) => ApiEndPoints.baseURL + image.toString();

String getChapterNumber(int index) {
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

  return list[index];
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

CourseTypes? getTypeOfCourse(String type) {
  for (var element in CourseTypes.values) {
    if (element.type == type) {
      return element;
    }
  }
  return null;
}

RoadmapView getLockRoadMapContainer =
    RoadmapView(Color(0xffD6D6D6), Assets.shape.shape4);

RoadmapView getRoadMapContainer(bool inRandom, RoadmapView? lastRoadMapView) {
  List<RoadmapView> colors = [
    RoadmapView(Color(0xffFF5EEA), Assets.shape.shape),
    RoadmapView(Color(0xff50FDAE), Assets.shape.shape1),
    RoadmapView(Color(0xffFEC86F), Assets.shape.shape2),
    RoadmapView(Color(0xffF817CFF), Assets.shape.shape4),
    RoadmapView(Color(0xffFB7A3E), Assets.shape.shape5),
    RoadmapView(Color(0xffA6DC59), Assets.shape.shape7),
  ];

  Random random = Random();
  int randomIndex = random.nextInt(colors.length);
  RoadmapView result = colors[0];
  if (inRandom) {
    result = colors[randomIndex];
  } else {
    if (lastRoadMapView != null) {
      for (int i = 0; i < colors.length; i++) {
        if (colors[i].color == lastRoadMapView.color) {
          return colors[i + 1];
        }
      }
    }
  }
  return result;
}

double getProgressCard(String progress) {
  try {
    final p = progress.replaceAll(" ", "");
    final indexOf = p.indexOf("/");
    final value = p.substring(0, indexOf);
    final all = p.substring(indexOf + 1);
    print(p);
    print(indexOf);
    print(value);
    print(all);
    if (all.startsWith("0")) {
      return 0;
    }
    final result = double.parse(value) / double.parse(all);
    return result;
  } catch (e) {
    return 0;
  }
}

String getFormatDuration(int totalSeconds) {
  final duration = Duration(seconds: totalSeconds);
  final minutes = duration.inMinutes;
  final seconds = totalSeconds % 60;

  final minutesString = '$minutes'.padLeft(2, '0');
  final secondsString = '$seconds'.padLeft(2, '0');
  return '$minutesString:$secondsString';
}

String getAlphIndex(int index) {
  switch (index) {
    case 0:
      return "الف) ";
    case 1:
      return "ب) ";
    case 2:
      return "ج) ";
    case 3:
      return "د) ";

    default:
      return '';
  }
}

String getIsoTimeMonthAndDay(String string) {
  try {
    DateTime now = DateTime.parse(string);
    Jalali j = Jalali(now.year, now.month, now.day);
    return "${j.day} ${j.formatter.mN}";
  } catch (e) {
    return "";
  }
}
