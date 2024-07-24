import 'package:ajhman/data/model/chapter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseText extends StatefulWidget {
  const CourseText({super.key});

  @override
  State<CourseText> createState() => _CourseTextState();
}

class _CourseTextState extends State<CourseText> {
  final highlight = [
    "data.highlight",
    "data.highlight",
    "data.highlight",
    "data.highlight",
  ];

  late ChapterModel data;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
