import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/progress/circle_progress.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseHeader extends StatefulWidget {
  const CourseHeader({super.key});

  @override
  State<CourseHeader> createState() => _CourseHeaderState();
}

class _CourseHeaderState extends State<CourseHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: DesignConfig.highBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                  text: "دوره آموزشی فنون مذاکره ",
                  style: mThemeData.textTheme.titleBold,
                  color: CupertinoColors.white),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: DesignConfig.highBorderRadius,
                  color: Colors.white.withOpacity(0.8)
                ),
                child: Row(
                  children: [
                  PrimaryText(text: "4.2", style: mThemeData.textTheme.searchHint, color: grayColor700),
                  SizedBox(width: 2,),
                  Icon(CupertinoIcons.star_fill,color: goldColor,size: 16,)
                ],),
              )
            ],
          ),
        ),
        SizedBox(height: 8,),
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: backgroundColor100, borderRadius: DesignConfig.highBorderRadius),
          child: Row(
            children: [
              CircleProgress(value: 0.8, strokeWidth: 6),
              SizedBox(width: 16,),
              PrimaryText(
                  text: "شما ۶۷ درصد از دوره را مشاهده کرده‌اید ",
                  style: mThemeData.textTheme.title,
                  color: grayColor700),
            ],
          ),
        ),
        SizedBox(height: 24,),
        PrimaryText(text: "بهترین روش مذاکره در ملاقات‌های شرکتی", style: mThemeData.textTheme.titleBold, color: primaryColor900),
        SizedBox(height: 40,),


      ],
    );
  }
}
