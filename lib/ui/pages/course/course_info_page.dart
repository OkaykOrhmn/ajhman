// ignore_for_file: deprecated_member_use, empty_catches, deprecated_member_use_from_same_package

import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/core/services/audio_handler.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/data/args/course_args.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/data/model/leaderboard_model.dart';
import 'package:ajhman/data/repository/course_repository.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/audio/audio_player_wave.dart';
import 'package:ajhman/ui/widgets/button/outline_primary_loading_button.dart';
import 'package:ajhman/ui/widgets/dialogs/dialog_handler.dart';
import 'package:ajhman/ui/widgets/states/default_place_holder.dart';
import 'package:ajhman/ui/widgets/text/marquee_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../core/cubit/home/news_course_home_cubit.dart';
import '../../../core/cubit/leaderboard/leaderboard_cubit.dart';
import '../../../core/bloc/language/language_bloc.dart';
import '../../../data/model/language.dart';
import '../../../data/shared_preferences/profile_data.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/colors.dart';
import '../../theme/design_config.dart';
import '../../widgets/animation/animated_visibility.dart';
import '../../widgets/button/loading_btn.dart';
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
  bool isInternational = false;
  late AudioHandler audioHandler;

  @override
  void initState() {
    if (widget.response.tag != null && widget.response.tag == "international" ||
        context.read<LanguageBloc>().state.selectedLanguage ==
            Language.english) {
      setState(() {
        isInternational = true;
      });
    }
    if (widget.response.category!.id == 6 && widget.response.audio != null) {
      audioHandler = AudioHandler(widget.response.audio.toString());
    }
    context.read<LeaderboardCubit>().setExamScore(widget.response.examScore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = widget.response;

    return Directionality(
      textDirection: isInternational ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
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
            CourseRating(
              id: data.id!,
            ),
            data.category!.id == 6
                ? data.audio != null
                    ? _bookAudioDownload()
                    : const SizedBox()
                : _pointsPlatform(),
            data.chapters!.isNotEmpty ? _chapters() : const SizedBox(),
            data.registered != null && data.registered! ||
                    data.category!.id == 6
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PrimaryLoadingButton(
                        title: isInternational ? "Register" : 'ثبت‌نام',
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
                              Future.delayed(Duration.zero, () {
                                DialogHandler(context).showRegCourseDialog(
                                    "دوره ${data.name} با موفقیت به بخش یادگیری حساب کاربری شما اضافه شد.",
                                    "متوجه شدم");
                                context.read<NewsCourseHomeCubit>().getNews();
                              });
                            } on DioError {}
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
            padding: const EdgeInsets.all(16)
                .copyWith(bottom: data.category!.id == 6 ? 140 : 90),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: DesignConfig.aVeryHighBorderRadius,
                  bottomRight: DesignConfig.aVeryHighBorderRadius),
              color: Theme.of(context).surfacePrimaryColor(),
            ),
            child: PrimaryImageNetwork(
                // src: "https://s3-alpha-sig.figma.com/img/3f9b/aad8/77bb617140ad8559927012205237ce01?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Snv8nK5EGr8NvHp4mj0wsxxtBVycYzhqCGZD5Ax8j-JT6ZpmEJ-nG5zNsHin6KSTaKka-av0R4QQ--XoX5zxdiQjTtKC32faE5sXtNnYIRBa3C12y-yq2q3WZ9RlmgRveutvI96Ag4Au9bLtXoa0ZYCrdXs1S2NArDN0FUfxDEuLwuYN7H9mSxLbNfH783YRuCESs9qzjb1u4tG4RSN9J96qSQmKfjvpfRvyqE2nzUDBV3hOPUhtIzRHFUHsjpFJ42ZRHtRLbCDn1xpeHEvPP4Skz5m8BHz-vWSW09Y-37~P-~YRgVL6DsqfCaGnzv7HxLw3jKrz9uFDtovhobMdEQ__",
                src: data.image.toString(),
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
                color: Theme.of(context).onWhite(),
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
                data.category!.id == 6 ? _infoesBook() : _infoes()
              ],
            ),
          ),
        )
      ],
    );
  }

  Column _infoes() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
                child: IconInfo(
                    icon: Assets.icon.outline.user,
                    desc:
                        "${data.users} ${isInternational ? "Participants" : 'فراگیر'}",
                    eng: isInternational)),
            Expanded(
                child: IconInfo(
                    icon: Assets.icon.outline.clock,
                    desc:
                        "${data.time} ${isInternational ? "Minutes" : 'دقیقه'}",
                    eng: isInternational)),
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
                    desc:
                        "${isInternational ? "Level" : 'سطح'} ${getLevel(data.level, isInternational)}",
                    eng: isInternational)),
            Expanded(
                child: IconInfo(
                    icon: Assets.icon.outline.note2,
                    desc: data.category!.name.toString(),
                    eng: isInternational)),
          ],
        ),
      ],
    );
  }

  Column _infoesBook() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.edit2,
                  desc: data.writer.toString()),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.note2, desc: "${data.pages} صفحه"),
            ),
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
                  icon: Assets.icon.outline.book,
                  desc: "انتشارات ${data.publisher}"),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.ranking,
                  desc: data.topic.toString()),
            ),
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
                  icon: Assets.icon.outline.microphone,
                  desc:
                      "خلاصه صوتی ${data.audio != null && data.audio!.isEmpty ? 'ن' : ''}دارد"),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.headphone,
                  desc: '${data.users} شنیده شده'),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
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
              text: isInternational
                  ? "Course Details"
                  : "توضیحات ${data.category!.id == 6 ? 'کتاب' : 'دوره'}",
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
                                  style: isInternational
                                      ? Theme.of(context)
                                          .textTheme
                                          .searchHintEng
                                      : Theme.of(context).textTheme.searchHint,
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
                  HtmlWidget(
                    data.description.toString(),
                    textStyle: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Theme.of(context).headText()),
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
                        text: isInternational
                            ? "What you'll learn"
                            : "آنچه در این ${data.category!.id == 6 ? 'کتاب خواهید خواند' : 'دوره می‌آموزیم'}",
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
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _pointsPlatform() {
    return BlocBuilder<LeaderboardCubit, int?>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
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
                              src: snapshot.data!.image.toString());
                        }),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryText(
                              text:
                                  isInternational ? "Your Score" : "نمره‌ی شما",
                              style: Theme.of(context).textTheme.titleBold,
                              color: Theme.of(context).pinTextFont()),
                          const SizedBox(
                            height: 8,
                          ),
                          state == null ? const SizedBox() : _resultExam(state),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: state != null && state > 60
                                    ? Theme.of(context).backgroundSuccess()
                                    : Theme.of(context).backgroundError(),
                                borderRadius: DesignConfig.highBorderRadius),
                            child: Center(
                              child: PrimaryText(
                                  text: state == null
                                      ? isInternational
                                          ? "No test given"
                                          : "آزمونی داده نشده"
                                      : "${state > 60 ? isInternational ? 'accepted' : "پذیرفته" : isInternational ? 'rejection' : "رد"} ${isInternational ? 'in the exam' : 'شده در آزمون'}",
                                  style: Theme.of(context).textTheme.title,
                                  color: state != null && state > 60
                                      ? successMain
                                      : errorMain),
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
                    title: isInternational
                        ? 'Go to the Leaderboard'
                        : "رفتن به سکوی امتیازات",
                    onTap: (Function startLoading, Function stopLoading,
                        ButtonState btnState) async {
                      if (btnState == ButtonState.idle) {
                        startLoading();
                        try {
                          LeaderboardModel response =
                              await courseRepository.getLeaderboard(data.id!);
                          navigatorKey.currentState!.pushNamed(
                              RoutePaths.leaderboard,
                              arguments: response);
                        } on DioError {}

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
      },
    );
  }

  Widget _bookAudioDownload() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).cardBackground(),
            borderRadius: DesignConfig.highBorderRadius),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Assets.image.audioBook.image(width: 64, height: 64),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(
                            text: 'خلاصه کتاب ${data.name}',
                            style: Theme.of(context).textTheme.titleBold,
                            color: Theme.of(context).pinTextFont()),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Assets.icon.outline.clock.svg(
                                width: 14,
                                height: 14,
                                color:
                                    Theme.of(context).placeholderBaseColor()),
                            const SizedBox(
                              width: 4,
                            ),
                            StreamBuilder(
                                stream: audioHandler.player.onDurationChanged,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return PrimaryText(
                                        text:
                                            "${snapshot.data != null && snapshot.data!.inHours != 0 ? '${snapshot.data!.inHours} ساعت و ' : ''}"
                                            "${snapshot.data != null && snapshot.data!.inMinutes != 0 ? '${snapshot.data!.inMinutes} دقیقه' : ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .searchHint,
                                        color: Theme.of(context)
                                            .placeholderBaseColor());
                                  } else {
                                    return const DefaultPlaceHolder(
                                        child: SizedBox(
                                      width: 120,
                                      height: 12,
                                    ));
                                  }
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            AudioPlayerWave(
              source: ApiEndPoints.baseURL + data.audio.toString(),
              name: ["کتاب ${data.name}"],
            ),
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
            text:
                "${isInternational ? 'Score obtained' : 'نمره کسب شده'}: $score",
            style: Theme.of(context).textTheme.title,
            color: score > 60
                ? Theme.of(context).fontSuccess()
                : Theme.of(context).fontError()),
      ],
    );
  }

  Widget _chapters() {
    return Column(
      children: [
        (data.tag != null && data.tag == 'mini') || data.category!.id! == 6
            ? const SizedBox()
            : TitleDivider(title: isInternational ? 'Chapters' : "سرفصل ها"),
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
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .white()
                                            .withOpacity(0.5),
                                        borderRadius:
                                            DesignConfig.highBorderRadius),
                                    child: const ThreeBounceLoading()),
                              )
                            : const SizedBox()
                      ],
                    );
                  },
                );
              }),
        ),
        (data.tag != null && data.tag == 'mini') || data.category!.id == 6
            ? const SizedBox()
            : _chapterLastLayout()
      ],
    );
  }

  Container _chapterLayout(int index) {
    final chapter = data.chapters![index];
    final isShow = chapter.isOpen!;
    chapter.completed = true;
    if (data.category!.id != 6) {
      chapter.subchapters?.forEach((element) {
        if (element.visited == false) {
          chapter.completed = false;
          return;
        }
      });

      if (chapter != data.chapters!.first) {
        if (data.chapters![index - 1].completed == null) {
          chapter.completed = null;
        } else {
          if (!data.chapters![index - 1].completed!) {
            chapter.completed = null;
          }
        }
      }
    }

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
                        text: (data.tag != null && data.tag == 'mini')
                            ? "شروع مینی دوره"
                            : data.category!.id == 6
                                ? 'فصل های کتاب'
                                : "${isInternational ? 'Chapter' : "فصل"} ${getChapterNumber(index, isInternational)}",
                        style: Theme.of(context).textTheme.dialogTitle,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(
                      width: 8,
                    ),
                    data.category!.id == 6
                        ? const SizedBox()
                        : chapter.completed == null
                            ? Assets.icon.outline.lock
                                .svg(color: Theme.of(context).secondaryColor())
                            : chapter.completed!
                                ? PrimaryText(
                                    text: isInternational
                                        ? '(Pass)'
                                        : "(گذرانده)",
                                    style:
                                        Theme.of(context).textTheme.titleBold,
                                    color: successMain)
                                : PrimaryText(
                                    text: isInternational
                                        ? "(In Progress)"
                                        : "(در حال یادگیری)",
                                    style:
                                        Theme.of(context).textTheme.titleBold,
                                    color: warningMain),
                  ],
                ),
                (data.tag != null && data.tag == 'mini') ||
                        data.category!.id == 6
                    ? const SizedBox()
                    : isShow
                        ? Assets.icon.outline.arrowUp
                            .svg(color: Theme.of(context).primaryColor)
                        : Assets.icon.outline.arrowDown
                            .svg(color: Theme.of(context).primaryColor)
              ],
            ),
          ),
          AnimatedVisibility(
              isVisible: (data.tag != null && data.tag == 'mini') ||
                      data.category!.id == 6
                  ? true
                  : isShow,
              duration: DesignConfig.lowAnimationDuration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  data.category!.id == 6
                      ? const SizedBox()
                      : MarqueeText(
                          text: chapter.name.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Theme.of(context).pinTextFont()),
                          stop: const Duration(seconds: 2),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  data.category!.id == 6
                      ? const SizedBox()
                      : Column(
                          children: [
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).cardBackground(),
                                        borderRadius:
                                            DesignConfig.highBorderRadius),
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Assets.icon.outline.documentCopy.svg(
                                            color: Theme.of(context)
                                                .secondaryColor()),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        PrimaryText(
                                            text:
                                                "${chapter.subchapters!.length} ${(data.tag != null && data.tag == 'mini') ? 'قسمت' : isInternational ? 'Subchapter' : 'زیر فصل'}",
                                            style: isInternational
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .searchHintEng
                                                : Theme.of(context)
                                                    .textTheme
                                                    .searchHint,
                                            color: Theme.of(context)
                                                .secondaryColor())
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).cardBackground(),
                                        borderRadius:
                                            DesignConfig.highBorderRadius),
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Assets.icon.outline.clock.svg(
                                            color: Theme.of(context)
                                                .secondaryColor()),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        PrimaryText(
                                            text:
                                                "${chapter.time} ${isInternational ? 'Minutes' : 'دقیقه'}",
                                            style: isInternational
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .searchHintEng
                                                : Theme.of(context)
                                                    .textTheme
                                                    .searchHint,
                                            color: Theme.of(context)
                                                .secondaryColor())
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).cardBackground(),
                                        borderRadius:
                                            DesignConfig.highBorderRadius),
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Assets.icon.outlineMedal.svg(
                                            color: Theme.of(context)
                                                .secondaryColor()),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        PrimaryText(
                                            text:
                                                "${chapter.score} ${isInternational ? 'Points' : 'امتیاز'}",
                                            style: isInternational
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .searchHintEng
                                                : Theme.of(context)
                                                    .textTheme
                                                    .searchHint,
                                            color: Theme.of(context)
                                                .secondaryColor())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                  _subchapters(chapter),
                  (data.tag != null && data.tag == 'mini')
                      ? Column(
                          children: [
                            _subchapterLayoutExam(
                                0,
                                Assets.icon.outline.video,
                                Subchapters(
                                    name: isInternational
                                        ? 'Summary of the course'
                                        : "جمع‌بندی دوره")),
                            _subchapterLayoutExam(
                                1,
                                Assets.icon.outline.exam,
                                Subchapters(
                                    name: isInternational
                                        ? 'Final exam of the first season'
                                        : "آزمون پایانی دوره")),
                          ],
                        )
                      : const SizedBox(),
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
                        text: isInternational ? 'Last Chapter' : "فصل آخر",
                        style: Theme.of(context).textTheme.dialogTitle,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(
                      width: 8,
                    ),
                    data.registered! &&
                            data.chapters!.last.completed != null &&
                            data.chapters!.last.completed!
                        ? const SizedBox()
                        : Assets.icon.outline.lock.svg(
                            color: Theme.of(context).secondaryColor(),
                            width: 18,
                            height: 18)
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
                      text: isInternational ? 'Conclusion' : "جمع‌بندی",
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
                  _subchapterLayoutExam(
                      0,
                      Assets.icon.outline.video,
                      Subchapters(
                          name: isInternational
                              ? 'Summary of the course'
                              : "جمع‌بندی")),
                  _subchapterLayoutExam(
                      1,
                      Assets.icon.outline.exam,
                      Subchapters(
                          name: isInternational
                              ? 'Final exam of the first season'
                              : "آزمون پایانی دوره")),
                ],
              ))
        ],
      ),
    );
  }

  SizedBox _subchapters(CourseMainChapters chapter) {
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

  Widget _subchapterLayout(int index, CourseMainChapters chapter) {
    final subchapter = chapter.subchapters![index];
    CourseTypes type = getType(subchapter.type!);
    return InkWell(
      onTap: (data.registered! &&
                  chapter.completed != null &&
                  (index == 0 ||
                      (subchapter != chapter.subchapters!.first &&
                          chapter.subchapters![index - 1].visited != null &&
                          chapter.subchapters![index - 1].visited!))) ||
              data.category!.id == 6
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
                        isInternational: isInternational,
                        chapterId: chapter.id!));
                setState(() {
                  chapter.subchapters![index].visited = true;
                });
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
                  ? Theme.of(context).onWhite()
                  : Theme.of(context).primaryColor50()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgGenImage(type.icon)
                        .svg(color: successMain, width: 16, height: 16),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MarqueeText(
                        text:
                            "${(data.tag != null && data.tag == 'mini') ? 'قسمت ${getChapterNumber(index, false)}: ' : ''}${subchapter.name.toString()}",
                        style: Theme.of(context).textTheme.searchHint.copyWith(
                            color: subchapter.visited!
                                ? Theme.of(context).progressText()
                                : grayColor900),
                        stop: const Duration(seconds: 2),
                      ),
                    )
                  ],
                ),
              ),
              (data.registered! &&
                          chapter.completed != null &&
                          (index == 0 ||
                              (subchapter != chapter.subchapters!.first &&
                                  chapter.subchapters![index - 1].visited !=
                                      null &&
                                  chapter.subchapters![index - 1].visited!))) ||
                      data.category!.id == 6
                  ? isInternational
                      ? Assets.icon.outline.arrowRight1.svg(
                          color: Theme.of(context).primaryColor,
                          width: 18,
                          height: 18)
                      : Assets.icon.outline.arrowLeft.svg(
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
    return BlocBuilder<ChapterBloc, ChapterState>(builder: (context, state) {
      return InkWell(
        onTap: data.registered! &&
                data.chapters!.last.completed != null &&
                data.chapters!.last.completed!
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
                color: data.examScore == 100
                    ? Theme.of(context).onWhite()
                    : Theme.of(context).primaryColor50()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      icon.svg(color: successMain, width: 16, height: 16),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MarqueeText(
                          text: subchapter.name.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .searchHint
                              .copyWith(
                                  color: data.examScore == 100
                                      ? Theme.of(context).progressText()
                                      : grayColor900),
                          stop: const Duration(seconds: 2),
                        ),
                      )
                    ],
                  ),
                ),
                data.registered! &&
                        data.chapters!.last.completed != null &&
                        data.chapters!.last.completed!
                    ? isInternational
                        ? Assets.icon.outline.arrowRight1.svg(
                            color: Theme.of(context).primaryColor,
                            width: 18,
                            height: 18)
                        : data.examScore == 100
                            ? Assets.icon.outline.tickSquare.svg(
                                color: Theme.of(context).primaryColor,
                                width: 18,
                                height: 18)
                            : Assets.icon.outline.arrowLeft.svg(
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
    });
  }
}
