import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseRating extends StatefulWidget {
  const CourseRating({super.key});

  @override
  State<CourseRating> createState() => _CourseRatingState();
}

class Rates {
  String title;
  int rate;

  Rates(this.title, this.rate);
}

class _CourseRatingState extends State<CourseRating> {
  final List<Rates> items = [
    Rates("جامع و کامل بودن دوره", 0),
    Rates("کیفیت ارائه مطالب", 0),
    Rates("انتقال درست مفاهیم", 0),
    Rates("میزان تسلط استاد به مفاهیم", 0),
    Rates("کاربردی بودن مفاهیم دوره", 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: backgroundColor100,
          borderRadius: DesignConfig.highBorderRadius),
      child: Column(
        children: [
          TitleDivider(
            title: "نظرات",
            hasPadding: false,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: DesignConfig.highBorderRadius),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.star_fill,
                      color: goldColor,
                      size: 32,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    PrimaryText(
                        text: "4.2",
                        style: mThemeData.textTheme.headerLargeBold,
                        color: grayColor700),
                    SizedBox(
                      width: 16,
                    ),
                    PrimaryText(
                        text: "(از ۳۴۱ رای)",
                        style: mThemeData.textTheme.title,
                        color: grayColor700)
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                PrimaryText(
                    text:
                        "نظرات شما باعث رشد و پیشرفت آژمان می‌شود ممنونم که در این راه ما را همراهی می‌کنید",
                    style: mThemeData.textTheme.rate,
                    color: grayColor700)
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          VerticalListView(
              items: items,
              item: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: DesignConfig.lowShadow,
                      borderRadius: DesignConfig.highBorderRadius),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: DesignConfig.mediumBorderRadius,
                              color: primaryColor,
                            ),
                            width: 2,
                            height: 12,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          PrimaryText(
                              text: items[index].title,
                              style: mThemeData.textTheme.title,
                              color: grayColor900)
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 38),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: grayColor, width: 1),
                                  ),
                                  width: 12,
                                  height: 12,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                PrimaryText(
                                    text: "ضعیف",
                                    style: mThemeData.textTheme.title,
                                    color: grayColor700),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: grayColor, width: 1),
                                  ),
                                  width: 12,
                                  height: 12,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                PrimaryText(
                                    text: "متوسط",
                                    style: mThemeData.textTheme.title,
                                    color: grayColor700),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: grayColor, width: 1),
                                  ),
                                  width: 12,
                                  height: 12,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                PrimaryText(
                                    text: "قوی",
                                    style: mThemeData.textTheme.title,
                                    color: grayColor700),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 8,
          ),
          OutlinedPrimaryButton(
            title: "ارسال تیکت به پشتیبانی",
            fill: true,
          )
        ],
      ),
    );
  }
}
