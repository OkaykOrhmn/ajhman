import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/course/course_chapter/screens/course_audio.dart';
import 'package:ajhman/ui/pages/course/course_chapter/screens/course_image.dart';
import 'package:ajhman/ui/pages/course/course_chapter/screens/course_text.dart';
import 'package:ajhman/ui/pages/course/course_chapter/screens/course_video.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../data/args/course_args.dart';
import '../../../../gen/assets.gen.dart';

class CourseChapterPage extends StatefulWidget {
  final CourseArgs args;

  const CourseChapterPage({super.key, required this.args});

  @override
  State<CourseChapterPage> createState() => _CourseChapterPageState();
}

class _CourseChapterPageState extends State<CourseChapterPage> {
  late CourseTypes courseTypes;
  late CourseArgs courseArgs;

  @override
  void initState() {
    courseArgs = widget.args;
    context.read<ChapterBloc>().add(GetInfoChapter(
        subChapterId: widget.args.ids![widget.args.subChapterId!],
        chapterId: widget.args.chapterId!));

    super.initState();
  }

  Widget _chapter(CourseTypes type) {
    switch (type) {
      case CourseTypes.audio:
        return CourseAudio();

      case CourseTypes.image:
        return CourseImage();

      case CourseTypes.text:
        return CourseText();

      case CourseTypes.video:
        return CourseVideo();

      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReversibleAppBar(title: "محتوای دوره"),
      body: BlocBuilder<ChapterBloc, ChapterState>(
        builder: (context, state) {
          if (state.status == ChapterStateStatus.success) {
            courseTypes = getType(state.data!.type);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  CourseHeader(
                    title: widget.args.chapterTitle.toString(),
                  ),
                  _main(),
                  CourseDetails(),
                  CourseRating(),
                  CourseComments()
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Column _main() {
    return Column(
      children: [
        _chapter(courseTypes),
        // Padding(
        //   padding:
        //       const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 40),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       CustomPrimaryButton(
        //         color: Colors.white,
        //         elevation: 0,
        //         onClick: () {
        //           // if (widget.args.subChapterId != 0) {
        //           // context.read<ChapterBloc>().add(GetInfoChapter(
        //           //     chapterId: courseArgs.chapterId!,
        //           //     subChapterId:
        //           //         courseArgs.ids![courseArgs.subChapterId!] - 1));
        //           // }
        //         },
        //         child: Row(
        //           children: [
        //             Assets.icon.outline.arrowRight
        //                 .svg(color: primaryColor, width: 16, height: 16),
        //             SizedBox(
        //               width: 8,
        //             ),
        //             PrimaryText(
        //                 text: "درس قبلی",
        //                 style: mThemeData.textTheme.rate,
        //                 color: primaryColor),
        //           ],
        //         ),
        //       ),
        //       CustomOutlinedPrimaryButton(
        //           onClick: () {
        //             // if (widget.args.subChapterId !=
        //             //     widget.args.ids!.length ) {
        //             // context.read<ChapterBloc>().add(GetInfoChapter(
        //             //     chapterId: courseArgs.chapterId!,
        //             //     subChapterId:
        //             //     courseArgs.ids![courseArgs.subChapterId!] + 1));
        //             // }
        //           },
        //           child: Row(
        //             children: [
        //               PrimaryText(
        //                   text: "درس بعدی",
        //                   style: mThemeData.textTheme.rate,
        //                   color: primaryColor),
        //               SizedBox(
        //                 width: 8,
        //               ),
        //               Assets.icon.outline.arrowLeft1
        //                   .svg(color: primaryColor, width: 16, height: 16)
        //             ],
        //           ))
        //     ],
        //   ),
        // )
      ],
    );
  }
}
