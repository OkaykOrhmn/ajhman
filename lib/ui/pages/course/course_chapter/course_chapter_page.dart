import 'dart:async';

import 'package:ajhman/core/cubit/subchapter/sub_chapter_cubit.dart';
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
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/animation/animated_visibility.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/custom_outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/custom_primary_button.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../../core/bloc/comments/comments_bloc.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../data/args/course_args.dart';
import '../../../../data/model/chapter_model.dart';
import '../../../../data/model/course_main_response_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/loading/three_bounce_loading.dart';

class CourseChapterPage extends StatefulWidget {
  final CourseArgs args;

  const CourseChapterPage({super.key, required this.args});

  @override
  State<CourseChapterPage> createState() => _CourseChapterPageState();
}

class _CourseChapterPageState extends State<CourseChapterPage> {
  late CourseTypes courseTypes;
  late CourseArgs courseArgs;
  late List<Subchapters> subChapters;
  final ScrollController scrollController = ScrollController();
  final ScrollController mainScrollController = ScrollController();
  Timer? timer;
  bool isOpen = false;
  late BuildContext sContext;

  @override
  void initState() {
    courseArgs = widget.args;
    context.read<CommentsBloc>().add(GetComments(
        chapterId: courseArgs.chapterId,
        subChapterId: courseArgs.chapterModel.id!));
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
  void dispose() {
    if (timer != null) {
      timer?.cancel();
    }
    super.dispose();
  }

  void _changeSubChapter(int id) {
    sContext.read<ChapterBloc>().add(
        GetInfoChapter(chapterId: widget.args.chapterId, subChapterId: id));
    sContext
        .read<ChapterBloc>()
        .stream
        .firstWhere((element) => element is ChapterSuccess)
        .then((value) {
      final state = value as ChapterSuccess;
      mainScrollController
          .jumpTo(mainScrollController.position.minScrollExtent);
      sContext.read<SubChapterCubit>().setData(CourseArgs(
          chapterId: widget.args.chapterId,
          courseData: widget.args.courseData,
          chapterModel: state.response));
      sContext
          .read<CommentsBloc>()
          .add(GetComments(chapterId: courseArgs.chapterId, subChapterId: id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReversibleAppBar(title: "محتوای دوره"),
      body: BlocProvider<SubChapterCubit>(
        create: (context) => SubChapterCubit(courseArgs),
        child: BlocBuilder<SubChapterCubit, CourseArgs>(
          builder: (c, state) {
            sContext = c;
            courseTypes = getType(state.chapterModel.type);
            for (var element in courseArgs.courseData.chapters!) {
              if (element.id == courseArgs.chapterId) {
                subChapters = element.subchapters!;
              }
            }

            return SingleChildScrollView(
              controller: mainScrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  CourseHeader(
                    title: courseArgs.courseData.name.toString(),
                  ),
                  _main(),
                  CourseDetails(),
                  CourseRating(),
                  CourseComments(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isOpen = !isOpen;
                        timer = Timer.periodic(
                            const Duration(milliseconds: 1),
                            (Timer t) => mainScrollController.jumpTo(
                                mainScrollController.position.maxScrollExtent));
                        Future.delayed(const Duration(milliseconds: 400))
                            .then((value) => timer?.cancel());
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: DesignConfig.aHighBorderRadius,
                          topLeft: DesignConfig.aHighBorderRadius,
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrimaryText(
                                  text: "زیرفصل‌های دوره",
                                  style: mThemeData.textTheme.dialogTitle,
                                  color: Colors.white),
                              true
                                  ? Assets.icon.outline.arrowUp
                                      .svg(color: Colors.white)
                                  : Assets.icon.outline.arrowDown
                                      .svg(color: Colors.white)
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          if (subChapters.isEmpty)
                            const SizedBox()
                          else
                            AnimatedVisibility(
                                isVisible: isOpen,
                                duration: DesignConfig.lowAnimationDuration,
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 400),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: RawScrollbar(
                                      thumbVisibility: true,
                                      trackVisibility: true,
                                      radius: DesignConfig.aHighBorderRadius,
                                      trackColor: Theme.of(context).primaryColor100(),
                                      thumbColor: Theme.of(context).primaryColor700(),
                                      trackRadius:
                                          DesignConfig.aVeryHighBorderRadius,
                                      interactive: true,
                                      controller: scrollController,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 18.0),
                                          child: ListView.builder(
                                              controller: scrollController,
                                              itemCount: subChapters.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return _subchapterLayout(
                                                    index, subChapters[index]);
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _subchapterLayout(int index, Subchapters subchapter) {
    CourseTypes type = getType(subchapter.type!);
    return InkWell(
      onTap: () {
        _changeSubChapter(subchapter.id!);
      },
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              color: subchapter.visited! ? backgroundColor200 : Theme.of(context).primaryColor50()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgGenImage(type.icon)
                      .svg(color: successMain, width: 16, height: 16),
                  const SizedBox(
                    width: 8,
                  ),
                  PrimaryText(
                      text: subchapter.name.toString(),
                      style: mThemeData.textTheme.searchHint,
                      color: grayColor900)
                ],
              ),
              Assets.icon.outline.arrowLeft
                  .svg(color: Theme.of(context).primaryColor, width: 18, height: 18)
            ],
          ),
        ),
      ),
    );
  }

  Column _main() {
    ChapterModel subchapter =
        sContext.read<SubChapterCubit>().state.chapterModel;
    return Column(
      children: [
        _chapter(courseTypes),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomOutlinedPrimaryButton(
                  onClick: subchapter.id != subChapters.last.id
                      ? () {
                          int index = subchapter.id!;
                          for (var element in subChapters) {
                            if (element.id == subchapter.id) {
                              index = subChapters.indexOf(element);
                            }
                          }
                          final subchapterId = subChapters[index + 1].id!;
                          _changeSubChapter(subchapterId);
                        }
                      : null,
                  child: Row(
                    children: [
                      Assets.icon.outline.arrowRight
                          .svg(color: Theme.of(context).primaryColor, width: 16, height: 16),
                      SizedBox(
                        width: 8,
                      ),
                      PrimaryText(
                          text: "درس بعدی",
                          style: mThemeData.textTheme.rate,
                          color: Theme.of(context).primaryColor),
                    ],
                  )),
              CustomPrimaryButton(
                color: Colors.white,
                elevation: 0,
                onClick: subchapter.id != subChapters.first.id
                    ? () {
                        int index = subchapter.id!;
                        for (var element in subChapters) {
                          if (element.id == subchapter.id) {
                            index = subChapters.indexOf(element);
                          }
                        }
                        final subchapterId = subChapters[index - 1].id!;
                        _changeSubChapter(subchapterId);
                      }
                    : null,
                child: Row(
                  children: [
                    PrimaryText(
                        text: "درس قبلی",
                        style: mThemeData.textTheme.rate,
                        color: Theme.of(context).primaryColor),
                    SizedBox(
                      width: 8,
                    ),
                    Assets.icon.outline.arrowLeft1
                        .svg(color: Theme.of(context).primaryColor, width: 16, height: 16),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
