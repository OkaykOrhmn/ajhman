import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/args/course_args.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../../widgets/animation/animated_visibility.dart';
import '../../widgets/button/outlined_primary_button.dart';
import '../../widgets/image/primary_image_network.dart';
import '../../widgets/image/profile_image_network.dart';
import '../../widgets/listview/highlight_listview.dart';
import '../../widgets/text/icon_info.dart';
import '../../widgets/text/primary_text.dart';
import '../../widgets/text/title_divider.dart';

class CourseInfo extends StatefulWidget {
  const CourseInfo({super.key, required this.response});

  final CourseMainResponseModel response;

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  late CourseMainResponseModel data;

  @override
  Widget build(BuildContext context) {
    data = widget.response;
    return Scaffold(
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
            // _pointsPlatform(),
            data.chapters!.isNotEmpty ? _chapters() : const SizedBox(),
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: DesignConfig.aVeryHighBorderRadius,
                  bottomRight: DesignConfig.aVeryHighBorderRadius),
              color: primaryColor,
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
                color: Colors.white,
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.defaultShadow),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  text: data.name.toString(),
                  style: mThemeData.textTheme.dialogTitle,
                  color: grayColor900,
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
            color: Colors.white),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              text: "توضیحات دوره",
              style: mThemeData.textTheme.dialogTitle,
              color: primaryColor900,
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
                                  style: mThemeData.textTheme.searchHint,
                                  color: grayColor700),
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
                    text: "توضیحات",
                    style: mThemeData.textTheme.title,
                    color: primaryColor900,
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
                        style: mThemeData.textTheme.dialogTitle,
                        color: primaryColor900,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      HighlightListView(
                          items: data.highlight!)
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
        decoration: const BoxDecoration(
            color: backgroundColor200,
            borderRadius: DesignConfig.highBorderRadius),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ProfileImageNetwork(
                    width: 64,
                    height: 64,
                    src:
                        "https://s3-alpha-sig.figma.com/img/6979/d837/b8c3d365a834f21f938e34ba7b745063?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K5k8b9iabWknGQvO~8wp0LRu~RGy9OZ2VdUcVft8gfvP9Hh0qfeRPKnzO-88UhmPSqGvsGOVXBU55tiIDZDBuAoEOUcd4RH9MJKhew9grmawB3a0uivmEKHZhhH46-hQfBUd-nbWkcu7GJY83hfpVubdYPpmlCpG7w87j01acFOCfcJvuAcprbyHxELs5NuJ4TRsgRRc1sOBx5yr08PI2xWZ3nlgw2z1KAeFACXAhTqizMFE7Qfv39MQoQM0~TvskHP2vZLUMNNowHRqDHrwPbXi75NS4cz6LYvAPPv1~uEa~mLEJn0M~k1KsFXhSE73zlSp8fbO~eA25n6EVLTI-g__"),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(4).copyWith(right: 8, left: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryText(
                                text: "جایگاه شما در میان شرکت کنندگان",
                                style: mThemeData.textTheme.titleBold,
                                color: grayColor800),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: PrimaryText(
                                      text: "25",
                                      style: mThemeData.textTheme.rate,
                                      color: successMain),
                                ),
                                Assets.icon.outline.arrowUp1.svg(
                                    color: successMain, width: 18, height: 18)
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Assets.icon.outline.star.svg(
                                    color: grayColor800, width: 14, height: 14),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4.0, right: 4),
                                  child: PrimaryText(
                                      text: '۱۵۴',
                                      style: mThemeData.textTheme.searchHint,
                                      color: grayColor800),
                                )
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 12,
                              color: primaryColor,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Assets.icon.outline.timer.svg(
                                    color: grayColor800, width: 14, height: 14),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4.0, right: 4),
                                  child: PrimaryText(
                                      text: '۲ دوره آموزشی',
                                      style: mThemeData.textTheme.searchHint,
                                      color: grayColor800),
                                )
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 12,
                              color: primaryColor,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Assets.icon.outline.note2.svg(
                                    color: grayColor800, width: 14, height: 14),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4.0, right: 4),
                                  child: PrimaryText(
                                      text: 'بدون گواهی نامه',
                                      style: mThemeData.textTheme.searchHint,
                                      color: grayColor800),
                                )
                              ],
                            ),
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
            Center(
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: OutlinedPrimaryButton(
                        title: "رفتن به لیدر سکوی امتیازات"))),
          ],
        ),
      ),
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
                return _chapterLayout(index);
              }),
        ),
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
          color: Colors.white,
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
                        text: "فصل ${getChapterNumber(index, data.chapters!)}",
                        style: mThemeData.textTheme.dialogTitle,
                        color: primaryColor),
                    SizedBox(
                      width: 8,
                    ),
                    completed
                        ? PrimaryText(
                            text: "(گذرانده)",
                            style: mThemeData.textTheme.titleBold,
                            color: successMain)
                        : PrimaryText(
                            text: "(در حال یادگیری)",
                            style: mThemeData.textTheme.titleBold,
                            color: warningMain),
                  ],
                ),
                isShow
                    ? Assets.icon.outline.arrowUp.svg(color: primaryColor)
                    : Assets.icon.outline.arrowDown.svg(color: primaryColor)
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
                      style: mThemeData.textTheme.title,
                      color: grayColor800),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
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
                                style: mThemeData.textTheme.searchHint,
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
                                style: mThemeData.textTheme.searchHint,
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
                                style: mThemeData.textTheme.searchHint,
                                color: secondaryColor)
                          ],
                        ),
                      ),
                    ],
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

  SizedBox _subchapters(Chapters chapter) {
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

  Widget _subchapterLayout(int index, Chapters chapter) {
    final subchapter = chapter.subchapters![index];
    CourseTypes type = getType(subchapter.type!);
    return InkWell(
      onTap: () {
        List<int> result = [];
        for (var element in chapter.subchapters!) {
          result.add(element.id!);
        }
        Navigator.of(context).pushNamed(RoutePaths.course,
            arguments: CourseArgs(
                chapter.id,
                chapter.name,
                index,
                result));
      },
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              color: subchapter.visited! ? backgroundColor200 : primaryColor50),
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
                  .svg(color: primaryColor, width: 18, height: 18)
            ],
          ),
        ),
      ),
    );
  }
}
