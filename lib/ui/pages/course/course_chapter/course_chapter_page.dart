import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/course/course_chapter/screens/course_audio.dart';
import 'package:ajhman/ui/pages/course/course_chapter/screens/course_image.dart';
import 'package:ajhman/ui/pages/course/course_chapter/screens/course_text.dart';
import 'package:ajhman/ui/pages/course/course_chapter/sections/course_comments.dart';
import 'package:ajhman/ui/pages/course/course_chapter/sections/course_details.dart';
import 'package:ajhman/ui/pages/course/course_chapter/sections/course_header.dart';
import 'package:ajhman/ui/pages/course/course_chapter/sections/course_rating.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/custom_outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/custom_primary_button.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

class CourseChapterPage extends StatefulWidget {
  const CourseChapterPage({super.key});

  @override
  State<CourseChapterPage> createState() => _CourseChapterPageState();
}

class _CourseChapterPageState extends State<CourseChapterPage> {
  Widget _chapter(CourseTypes type) {
    switch (type) {
      case CourseTypes.audio:
        return CourseAudio();

      case CourseTypes.image:
        return CourseImage();

      case CourseTypes.text:
        return CourseText();

      case CourseTypes.video:
        return SizedBox();

      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReversibleAppBar(title: "محتوای دوره"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CourseHeader(),
            _main(),
            CourseDetails(),
            CourseRating(),
            CourseComments()
          ],
        ),
      ),
    );
  }

  Column _main() {
    return Column(
      children: [
        _chapter(CourseTypes.audio),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPrimaryButton(
                color: Colors.white,
                elevation: 0,
                onClick: () {},
                child: Row(
                  children: [
                    Assets.icon.outline.arrowRight
                        .svg(color: primaryColor, width: 16, height: 16),
                    SizedBox(
                      width: 8,
                    ),
                    PrimaryText(
                        text: "درس قبلی",
                        style: mThemeData.textTheme.rate,
                        color: primaryColor),
                  ],
                ),
              ),
              CustomOutlinedPrimaryButton(
                  child: Row(
                children: [
                  PrimaryText(
                      text: "درس بعدی",
                      style: mThemeData.textTheme.rate,
                      color: primaryColor),
                  SizedBox(
                    width: 8,
                  ),
                  Assets.icon.outline.arrowLeft1
                      .svg(color: primaryColor, width: 16, height: 16)
                ],
              ))
            ],
          ),
        )
      ],
    );
  }
}
