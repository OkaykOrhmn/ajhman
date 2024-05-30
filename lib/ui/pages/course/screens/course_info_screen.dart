import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../theme/color/colors.dart';
import '../../../theme/widget/design_config.dart';
import '../../../widgets/animation/animated_visibility.dart';
import '../../../widgets/button/outlined_primary_button.dart';
import '../../../widgets/image/primary_image_network.dart';
import '../../../widgets/image/profile_image_network.dart';
import '../../../widgets/listview/highlight_listview.dart';
import '../../../widgets/text/icon_info.dart';
import '../../../widgets/text/primary_text.dart';
import '../../../widgets/text/title_divider.dart';

class CourseInfoScreen extends StatefulWidget {
  const CourseInfoScreen({super.key, required this.response});

  final CourseMainResponseModel response;

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  List<String> items = [
    "مفاهیم و تکنیک های مذاکره",
    "انواع مذاکره و روش‌های آن",
    "زبان بدن و مفاهیم آن",
    "بایدها و نبایدها در مذاکره",
    "شناخت شخصیت ها و نحوه استفاده از آن در مذاکره"
  ];
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final data = widget.response;
    return SingleChildScrollView(
        child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                    child: const PrimaryImageNetwork(
                        src:
                            "https://s3-alpha-sig.figma.com/img/3f9b/aad8/77bb617140ad8559927012205237ce01?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Snv8nK5EGr8NvHp4mj0wsxxtBVycYzhqCGZD5Ax8j-JT6ZpmEJ-nG5zNsHin6KSTaKka-av0R4QQ--XoX5zxdiQjTtKC32faE5sXtNnYIRBa3C12y-yq2q3WZ9RlmgRveutvI96Ag4Au9bLtXoa0ZYCrdXs1S2NArDN0FUfxDEuLwuYN7H9mSxLbNfH783YRuCESs9qzjb1u4tG4RSN9J96qSQmKfjvpfRvyqE2nzUDBV3hOPUhtIzRHFUHsjpFJ42ZRHtRLbCDn1xpeHEvPP4Skz5m8BHz-vWSW09Y-37~P-~YRgVL6DsqfCaGnzv7HxLw3jKrz9uFDtovhobMdEQ__",
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
                          style: themeData.textTheme.dialogTitle,
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
                                    icon: Assets.icon.outline.clock,
                                    desc: "۵۶ ساعت")),
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
                                    desc: "سطح متوسط")),
                            Expanded(
                                child: IconInfo(
                                    icon: Assets.icon.outline.note2,
                                    desc: "مدیریت کسب و کار")),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
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
                      style: themeData.textTheme.dialogTitle,
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
                                          style: themeData.textTheme.searchHint,
                                          color: grayColor700),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      CupertinoIcons.star_fill,
                                      size: 14,
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
                            style: themeData.textTheme.title,
                            color: primaryColor900,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PrimaryText(
                      text: "آنچه در این دوره می‌آموزیم",
                      style: themeData.textTheme.dialogTitle,
                      color: primaryColor900,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    HighlightListView(
                        items: items,
                        item: (index) => Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: grayColor600,
                                  ),
                                ),
                                PrimaryText(
                                    text: items[index],
                                    style: themeData.textTheme.title,
                                    color: grayColor600)
                              ],
                            ))
                  ],
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: OutlinedPrimaryButton(
                      title: "رفتن به نوشته و نشان شده‌ها")),
            )),
            Padding(
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
                            padding: const EdgeInsets.all(4)
                                .copyWith(right: 8, left: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PrimaryText(
                                        text: "جایگاه شما در میان شرکت کنندگان",
                                        style: themeData.textTheme.titleBold,
                                        color: grayColor800),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: PrimaryText(
                                              text: "25",
                                              style: themeData.textTheme.rate,
                                              color: successMain),
                                        ),
                                        Assets.icon.outline.arrowUp1.svg(
                                            color: successMain,
                                            width: 18,
                                            height: 18)
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Assets.icon.outline.star.svg(
                                            color: grayColor800,
                                            width: 14,
                                            height: 14),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4.0, right: 4),
                                          child: PrimaryText(
                                              text: '۱۵۴',
                                              style: themeData
                                                  .textTheme.searchHint,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Assets.icon.outline.timer.svg(
                                            color: grayColor800,
                                            width: 14,
                                            height: 14),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4.0, right: 4),
                                          child: PrimaryText(
                                              text: '۲ دوره آموزشی',
                                              style: themeData
                                                  .textTheme.searchHint,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Assets.icon.outline.note2.svg(
                                            color: grayColor800,
                                            width: 14,
                                            height: 14),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4.0, right: 4),
                                          child: PrimaryText(
                                              text: 'بدون گواهی نامه',
                                              style: themeData
                                                  .textTheme.searchHint,
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
            ),
            TitleDivider(title: "سرفصل‌ها"),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(16),
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
                                isShow = !isShow;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    PrimaryText(
                                        text: "فصل اول",
                                        style: themeData.textTheme.dialogTitle,
                                        color: primaryColor),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    PrimaryText(
                                        text: "(گذرانده)",
                                        style: themeData.textTheme.titleBold,
                                        color: successMain),
                                  ],
                                ),
                                isShow
                                    ? Assets.icon.outline.arrowUp
                                        .svg(color: primaryColor)
                                    : Assets.icon.outline.arrowDown
                                        .svg(color: primaryColor)
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
                                      text: "تعاریف کلی ومدل ذهنی مذاکره کننده",
                                      style: themeData.textTheme.title,
                                      color: grayColor800),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: backgroundColor200,
                                            borderRadius:
                                                DesignConfig.highBorderRadius),
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Assets.icon.outline.documentCopy
                                                .svg(color: secondaryColor),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            PrimaryText(
                                                text: "۷ زیر فصل",
                                                style: themeData
                                                    .textTheme.searchHint,
                                                color: secondaryColor)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: backgroundColor200,
                                            borderRadius:
                                                DesignConfig.highBorderRadius),
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Assets.icon.outline.documentCopy
                                                .svg(color: secondaryColor),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            PrimaryText(
                                                text: "۷ زیر فصل",
                                                style: themeData
                                                    .textTheme.searchHint,
                                                color: secondaryColor)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: backgroundColor200,
                                            borderRadius:
                                                DesignConfig.highBorderRadius),
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Assets.icon.outline.documentCopy
                                                .svg(color: secondaryColor),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            PrimaryText(
                                                text: "۷ زیر فصل",
                                                style: themeData
                                                    .textTheme.searchHint,
                                                color: secondaryColor)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: ListView.builder(
                                          itemCount: 4,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                padding: EdgeInsets.all(18),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                decoration: const BoxDecoration(
                                                    borderRadius: DesignConfig
                                                        .highBorderRadius,
                                                    color: backgroundColor200),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Assets.icon.bold.video
                                                            .svg(
                                                                color:
                                                                    successMain,
                                                                width: 16,
                                                                height: 16),
                                                        PrimaryText(
                                                            text:
                                                                "مفهوم ارزش در مذاکره + تحلیل مذاکره زنده",
                                                            style: themeData
                                                                .textTheme
                                                                .searchHint,
                                                            color: grayColor900)
                                                      ],
                                                    ),
                                                    Assets
                                                        .icon.outline.arrowLeft
                                                        .svg(
                                                            color: primaryColor,
                                                            width: 18,
                                                            height: 18)
                                                  ],
                                                ),
                                              ),
                                            );
                                          }))
                                ],
                              ))
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 200,
        )
      ],
    ));
  }
}
