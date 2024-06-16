import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/carousel/carousel_course_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';
import '../../../../../main.dart';
import '../../../../theme/color/colors.dart';
import '../../../../widgets/listview/highlight_listview.dart';
import '../../../../widgets/text/primary_text.dart';

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
    final data = context.read<SubChapterCubit>().state!.chapterModel;
    return SizedBox();
  }
}
