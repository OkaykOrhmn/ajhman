import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';


class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16).copyWith(bottom: _showMore? 48 : 16),
          decoration: BoxDecoration(
              boxShadow: DesignConfig.lowShadow,
              color: CupertinoColors.white,
              borderRadius: DesignConfig.highBorderRadius),
          child: Column(
            children: [
              TitleDivider(
                title: "توضیحات جلسه",
                hasPadding: false,
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: PrimaryText(
                  text:
                      "فنون مذاکره یکی از مهم‌ترین مهارت‌ها در دنیای امروز است. برای اینکه یک فرد به یک مذاکره‌کننده خوب تبدیل شود لازم است تا بتواند باورها و عقاید افراد، حالات روحی، ترجیحات و ترس‌ها و ویژگی‌های شخصیتی و تفاوت‌های فرهنگی را به خوبی درک کرده و برای موفقیت در مذاکره از آنها بهره ببرد. \nمسئله اصلی هر مذاکره بحث توافق است. این توافق می‌تواند بخش‌های مختلف زندگی فرد را برگیرد و باعث موفقیت یا شکست او شود. فروشندگان موفق معمولا مذاکره‌کنندگان موفقی هستند که به کمک این مهارت می‌توانند مشتریان خود را برای خرید یک محصول قانع کرده و به توافقی سودآور دست یابند.",
                  style: mThemeData.textTheme.title,
                  color: grayColor900,
                  textAlign: TextAlign.justify,
                  maxLines: _showMore ? null : 10,
                ),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              alignment: Alignment.bottomCenter,
              decoration: _showMore
                  ? null
                  : BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.9),
                          Colors.white,
                        ],
                      ),
                    ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showMore = !_showMore;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: primaryColor50),
                  width: 40,
                  height: 40,
                  child: Center(
                      child: _showMore
                          ? Assets.icon.outline.arrowUp
                              .svg(width: 24, height: 24, color: primaryColor)
                          : Assets.icon.outline.arrowDown
                              .svg(width: 24, height: 24, color: primaryColor)),
                ),
              ),
            ))
      ],
    );
  }
}
