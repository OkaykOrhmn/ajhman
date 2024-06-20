import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/args/course_args.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/data/model/leaderboard_model.dart';
import 'package:ajhman/data/repository/course_repository.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/outline_primary_loading_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/dialogs/dialog_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../core/cubit/home/news_course_home_cubit.dart';
import '../../../data/args/exam_args.dart';
import '../../../data/shared_preferences/profile_data.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../../widgets/animation/animated_visibility.dart';
import '../../widgets/button/loading_btn.dart';
import '../../widgets/button/outlined_primary_button.dart';
import '../../widgets/image/primary_image_network.dart';
import '../../widgets/image/profile_image_network.dart';
import '../../widgets/listview/highlight_listview.dart';
import '../../widgets/loading/three_bounce_loading.dart';
import '../../widgets/text/icon_info.dart';
import '../../widgets/text/primary_text.dart';
import '../../widgets/text/title_divider.dart';
import 'course_chapter/sections/course_rating.dart';

class CourseInfoPage extends StatefulWidget {
  const CourseInfoPage({super.key, required this.response});

  final CourseMainResponseModel response;

  @override
  State<CourseInfoPage> createState() => _CourseInfoPageState();
}

class _CourseInfoPageState extends State<CourseInfoPage> {
  late CourseMainResponseModel data;

  bool isShowLast = false;

  @override
  Widget build(BuildContext context) {
    data = widget.response;
    return Scaffold(
      backgroundColor: Theme.of(context).background(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _information(),
            // Center(
            //     child: Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: SizedBox(
            //       width: MediaQuery.sizeOf(context).width,
            //       child: const OutlinedPrimaryButton(
            //           title: "رفتن به نوشته و نشان شده‌ها")),
            // )),
            CourseRating(id: data.id!,),
            _pointsPlatform(),
            data.chapters!.isNotEmpty ? _chapters() : const SizedBox(),
            data.registered != null && data.registered!
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PrimaryLoadingButton(
                        title: 'ثبت‌نام',
                        disable: false,
                        onTap: (Function startLoading, Function stopLoading,
                            ButtonState btnState) async {
                          if (btnState == ButtonState.idle) {
                            startLoading();
                            try {
                              await courseRepository.getRegCourse(data.id!);
                              setState(() {
                                widget.response.registered = true;
                              });
                              DialogHandler(context).showRegCourseDialog(
                                  "دوره “فنون مذاکره” با موفقیت به بخش یادگیری حساب کاربری شما اضافه شد.",
                                  "متوجه شدم");
                              context.read<NewsCourseHomeCubit>().getNews();
                            } on DioError catch (e) {}
                          }

                          stopLoading();
                        }),
                  ),
          ],
        ),
      )),
    );
  }

  Widget _header() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 60),
          child: Container(
            padding: const EdgeInsets.all(16).copyWith(bottom: 90),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: DesignConfig.aVeryHighBorderRadius,
                  bottomRight: DesignConfig.aVeryHighBorderRadius),
              color: Theme.of(context).surfacePrimaryColor(),
            ),
            child: PrimaryImageNetwork(
                // src: "https://s3-alpha-sig.figma.com/img/3f9b/aad8/77bb617140ad8559927012205237ce01?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Snv8nK5EGr8NvHp4mj0wsxxtBVycYzhqCGZD5Ax8j-JT6ZpmEJ-nG5zNsHin6KSTaKka-av0R4QQ--XoX5zxdiQjTtKC32faE5sXtNnYIRBa3C12y-yq2q3WZ9RlmgRveutvI96Ag4Au9bLtXoa0ZYCrdXs1S2NArDN0FUfxDEuLwuYN7H9mSxLbNfH783YRuCESs9qzjb1u4tG4RSN9J96qSQmKfjvpfRvyqE2nzUDBV3hOPUhtIzRHFUHsjpFJ42ZRHtRLbCDn1xpeHEvPP4Skz5m8BHz-vWSW09Y-37~P-~YRgVL6DsqfCaGnzv7HxLw3jKrz9uFDtovhobMdEQ__",
                src: getImageUrl(data.image),
                aspectRatio: 16 / 9),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Theme.of(context).white(),
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.lowShadow),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  text: data.name.toString(),
                  style: Theme.of(context).textTheme.dialogTitle,
                  color: Theme.of(context).progressText(),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: IconInfo(
                            icon: Assets.icon.outline.user,
                            desc: "۱٬۳۴۲ فراگیر")),
                    Expanded(
                        child: IconInfo(
                            icon: Assets.icon.outline.clock, desc: "۵۶ ساعت")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: IconInfo(
                            icon: Assets.icon.outline.chart,
                            desc: "سطح ${getLevel(data.level)}")),
                    Expanded(
                        child: IconInfo(
                            icon: Assets.icon.outline.note2,
                            desc: data.category!.name.toString())),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _information() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: DesignConfig.highBorderRadius,
            boxShadow: DesignConfig.lowShadow,
            color: Theme.of(context).white()),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              text: "توضیحات دوره",
              style: Theme.of(context).textTheme.dialogTitle,
              color: Theme.of(context).headText(),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: PrimaryText(
                                  text: "3.2",
                                  style: Theme.of(context).textTheme.searchHint,
                                  color: Theme.of(context).cardText()),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Assets.icon.outline.star.svg(
                              width: 16,
                              height: 16,
                              color: goldColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryText(
                    text: data.description.toString(),
                    style: Theme.of(context).textTheme.title,
                    color: Theme.of(context).headText(),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            data.highlight!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        text: "آنچه در این دوره می‌آموزیم",
                        style: Theme.of(context).textTheme.dialogTitle,
                        color: Theme.of(context).headText(),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      HighlightListView(items: data.highlight!)
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _pointsPlatform() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:  BoxDecoration(
            color: Theme.of(context).cardBackground(),
            borderRadius: DesignConfig.highBorderRadius),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                    future: getProfile(),
                    builder: (context, snapshot) {
                      return ProfileImageNetwork(
                          width: 64,
                          height: 64,
                          src: getImageUrl(snapshot.data!.image));
                    }),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                          text: "نمره‌ی شما",
                          style: Theme.of(context).textTheme.titleBold,
                          color: Theme.of(context).pinTextFont()),
                      SizedBox(
                        height: 8,
                      ),
                      data.examScore == null
                          ? const SizedBox()
                          : _resultExam(data.examScore!),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundSuccess(),
                            borderRadius: DesignConfig.highBorderRadius),
                        child: Center(
                          child: PrimaryText(
                              text: data.examScore == null
                                  ? "آزمونی داده نشده"
                                  : "${80 > 60 ? "پذیرفته" : "رد"} شده در آزمون",
                              style: Theme.of(context).textTheme.title,
                              color: 80 > 60 ? successMain : errorMain),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
                child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: OutlinePrimaryLoadingButton(
                title: "رفتن به سکوی امتیازات",
                onTap: (Function startLoading, Function stopLoading,
                    ButtonState btnState) async {
                  if (btnState == ButtonState.idle) {
                    startLoading();
                    try {
                      LeaderboardModel response =
                          await courseRepository.getLeaderboard(4);
                      if (response.user != null && response.users != null) {
                        navigatorKey.currentState!.pushNamed(
                            RoutePaths.leaderboard,
                            arguments: response);
                      }
                    } on DioError catch (e) {}

                    stopLoading();
                  }
                },
                disable: false,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Row _resultExam(int score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PrimaryText(
            text: "نمره کسب شده: ${score}",
            style: Theme.of(context).textTheme.title,
            color: score > 60 ? Theme.of(context).fontSuccess() : Theme.of(context).fontError()),
      ],
    );
  }

  Widget _chapters() {
    return Column(
      children: [
        const TitleDivider(title: "سرفصل‌ها"),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.chapters!.length,
              itemBuilder: (context, index) {
                return BlocBuilder<ChapterBloc, ChapterState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                        IgnorePointer(
                            ignoring: state is ChapterLoading,
                            child: _chapterLayout(index)),
                        state is ChapterLoading && data.chapters![index].isOpen!
                            ? Positioned.fill(
                                child: Container(
                                    color: Theme.of(context).white().withOpacity(0.5),
                                    child: const ThreeBounceLoading()),
                              )
                            : const SizedBox()
                      ],
                    );
                  },
                );
              }),
        ),
        _chapterLastLayout()
      ],
    );
  }

  Container _chapterLayout(int index) {
    final chapter = data.chapters![index];
    final isShow = chapter.isOpen!;
    bool completed = true;
    chapter.subchapters?.forEach((element) {
      if (element.visited == false) {
        completed = false;
        return;
      }
    });
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).white(),
          boxShadow: DesignConfig.lowShadow,
          borderRadius: DesignConfig.highBorderRadius),
      child: Column(
        children: [
          InkWell(
            borderRadius: DesignConfig.highBorderRadius,
            onTap: () {
              setState(() {
                chapter.isOpen = !isShow;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    PrimaryText(
                        text: "فصل ${getChapterNumber(index)}",
                        style: Theme.of(context).textTheme.dialogTitle,
                        color: Theme.of(context).primaryColor),
                    SizedBox(
                      width: 8,
                    ),
                    completed
                        ? PrimaryText(
                            text: "(گذرانده)",
                            style: Theme.of(context).textTheme.titleBold,
                            color: successMain)
                        : PrimaryText(
                            text: "(در حال یادگیری)",
                            style: Theme.of(context).textTheme.titleBold,
                            color: warningMain),
                  ],
                ),
                isShow
                    ? Assets.icon.outline.arrowUp
                        .svg(color: Theme.of(context).primaryColor)
                    : Assets.icon.outline.arrowDown
                        .svg(color: Theme.of(context).primaryColor)
              ],
            ),
          ),
          AnimatedVisibility(
              isVisible: isShow,
              duration: DesignConfig.lowAnimationDuration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryText(
                      text: chapter.name.toString(),
                      style: Theme.of(context).textTheme.title,
                      color: Theme.of(context).pinTextFont()),
                  const SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration:  BoxDecoration(
                              color: Theme.of(context).cardBackground(),
                              borderRadius: DesignConfig.highBorderRadius),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Assets.icon.outline.documentCopy
                                  .svg(color: Theme.of(context).secondaryColor()),
                              const SizedBox(
                                width: 8,
                              ),
                              PrimaryText(
                                  text:
                                      "${chapter.subchapters!.length} زیر فصل",
                                  style: Theme.of(context).textTheme.searchHint,
                                  color: Theme.of(context).secondaryColor())
                            ],
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Container(
                          decoration:  BoxDecoration(
                              color: Theme.of(context).cardBackground(),
                              borderRadius: DesignConfig.highBorderRadius),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Assets.icon.outline.clock
                                  .svg(color: Theme.of(context).secondaryColor()),
                              const SizedBox(
                                width: 8,
                              ),
                              PrimaryText(
                                  text: "${chapter.time} ساعت",
                                  style: Theme.of(context).textTheme.searchHint,
                                  color: Theme.of(context).secondaryColor())
                            ],
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Container(
                          decoration:  BoxDecoration(
                              color: Theme.of(context).cardBackground(),
                              borderRadius: DesignConfig.highBorderRadius),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Assets.icon.outlineMedal
                                  .svg(color: Theme.of(context).secondaryColor()),
                              const SizedBox(
                                width: 8,
                              ),
                              PrimaryText(
                                  text: "${chapter.score} امتیاز",
                                  style: Theme.of(context).textTheme.searchHint,
                                  color: Theme.of(context).secondaryColor())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _subchapters(chapter)
                ],
              ))
        ],
      ),
    );
  }

  Container _chapterLastLayout() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).white(),
          boxShadow: DesignConfig.lowShadow,
          borderRadius: DesignConfig.highBorderRadius),
      child: Column(
        children: [
          InkWell(
            borderRadius: DesignConfig.highBorderRadius,
            onTap: () {
              setState(() {
                isShowLast = !isShowLast;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    PrimaryText(
                        text: "فصل آخر",
                        style: Theme.of(context).textTheme.dialogTitle,
                        color: Theme.of(context).primaryColor),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                isShowLast
                    ? Assets.icon.outline.arrowUp
                        .svg(color: Theme.of(context).primaryColor)
                    : Assets.icon.outline.arrowDown
                        .svg(color: Theme.of(context).primaryColor)
              ],
            ),
          ),
          AnimatedVisibility(
              isVisible: isShowLast,
              duration: DesignConfig.lowAnimationDuration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryText(
                      text: "جمع‌بندی",
                      style: Theme.of(context).textTheme.title,
                      color: Theme.of(context).pinTextFont()),
                  const SizedBox(
                    height: 16,
                  ),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: backgroundColor200,
                            borderRadius: DesignConfig.highBorderRadius),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Assets.icon.outline.documentCopy
                                .svg(color: secondaryColor),
                            const SizedBox(
                              width: 8,
                            ),
                            PrimaryText(
                                text: "${chapter.subchapters!.length} زیر فصل",
                                style: Theme.of(context).textTheme.searchHint,
                                color: secondaryColor)
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: backgroundColor200,
                            borderRadius: DesignConfig.highBorderRadius),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Assets.icon.outline.clock
                                .svg(color: secondaryColor),
                            const SizedBox(
                              width: 8,
                            ),
                            PrimaryText(
                                text: "${chapter.time} ساعت",
                                style: Theme.of(context).textTheme.searchHint,
                                color: secondaryColor)
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: backgroundColor200,
                            borderRadius: DesignConfig.highBorderRadius),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Assets.icon.outlineMedal.svg(color: secondaryColor),
                            const SizedBox(
                              width: 8,
                            ),
                            PrimaryText(
                                text: "${chapter.score} امتیاز",
                                style: Theme.of(context).textTheme.searchHint,
                                color: secondaryColor)
                          ],
                        ),
                      ),
                    ],
                  )*/
                  const SizedBox(
                    height: 16,
                  ),
                  _subchapterLayoutExam(0, Assets.icon.outline.video,
                      Subchapters(name: "جمع‌بندی دوره")),
                  _subchapterLayoutExam(1, Assets.icon.outline.exam,
                      Subchapters(name: "آزمون پایانی دوره")),
                ],
              ))
        ],
      ),
    );
  }

  SizedBox _subchapters(courseMainChapters chapter) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: ListView.builder(
            itemCount: chapter.subchapters!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _subchapterLayout(index, chapter);
            }));
  }

  Widget _subchapterLayout(int index, courseMainChapters chapter) {
    final subchapter = chapter.subchapters![index];
    CourseTypes type = getType(subchapter.type!);
    return InkWell(
      onTap: data.registered!
          ? () async {
              context.read<ChapterBloc>().add(GetInfoChapter(
                  chapterId: chapter.id!, subChapterId: subchapter.id!));
              context
                  .read<ChapterBloc>()
                  .stream
                  .firstWhere((element) => element is ChapterSuccess)
                  .then((value) {
                final state = value as ChapterSuccess;
                Navigator.of(context).pushNamed(RoutePaths.course,
                    arguments: CourseArgs(
                        courseData: widget.response,
                        chapterModel: state.response,
                        chapterId: chapter.id!));
              });
            }
          : null,
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              color: subchapter.visited!
                  ? Theme.of(context).cardBackground()
                  : Theme.of(context).primaryColor50()),
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
                      style: Theme.of(context).textTheme.searchHint,
                      color: grayColor900)
                ],
              ),
              data.registered!
                  ? Assets.icon.outline.arrowLeft.svg(
                      color: Theme.of(context).primaryColor,
                      width: 18,
                      height: 18)
                  : Assets.icon.outline.lock
                      .svg(color: grayColor700, width: 18, height: 18)
            ],
          ),
        ),
      ),
    );
  }

  Widget _subchapterLayoutExam(
      int index, SvgGenImage icon, Subchapters subchapter) {
    return InkWell(
      onTap: data.registered!
          ? () {
              String r;
              if (index == 0) {
                r = RoutePaths.summery;
              } else {
                r = RoutePaths.examInfo;
              }
              Navigator.of(context).pushNamed(r, arguments: data.id!);
            }
          : null,
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              color: Theme.of(context).primaryColor50()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon.svg(color: successMain, width: 16, height: 16),
                  const SizedBox(
                    width: 8,
                  ),
                  PrimaryText(
                      text: subchapter.name.toString(),
                      style: Theme.of(context).textTheme.searchHint,
                      color: grayColor900)
                ],
              ),
              data.registered!
                  ? Assets.icon.outline.arrowLeft.svg(
                      color: Theme.of(context).primaryColor,
                      width: 18,
                      height: 18)
                  : Assets.icon.outline.lock
                      .svg(color: grayColor700, width: 18, height: 18)
            ],
          ),
        ),
      ),
    );
  }
}
