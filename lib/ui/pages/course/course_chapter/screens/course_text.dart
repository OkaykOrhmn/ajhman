import 'package:ajhman/data/model/chapter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';

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
    final data = context.read<SubChapterCubit>().state.chapterModel;
    return const SizedBox();
  }
}
