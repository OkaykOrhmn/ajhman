import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../main.dart';
import '../../../theme/color/colors.dart';
import '../../../theme/widget/design_config.dart';
import '../../../widgets/listview/highlight_listview.dart';
import '../../../widgets/text/primary_text.dart';

class ExamInfoScreen extends StatefulWidget{
  final String comment;
  const ExamInfoScreen({super.key, required this.comment});

  @override
  State<ExamInfoScreen> createState() => _ExamInfoScreenState();
}

class _ExamInfoScreenState extends State<ExamInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryText(
            text: "آزمون فنون مذاکره",
            style: mThemeData.textTheme.dialogTitle,
            color: Theme.of(context).primaryColor900()),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              color: backgroundColor100),
          child: Column(
            children: [
              _examInfoIconRow("۱۰ سوال", "سوال ۴ گزینه‌ای",
                  Assets.icon.outline.task),
              SizedBox(
                height: 16,
              ),
              _examInfoIconRow("۲ دقیقه", "زمان پاسخگویی به سوال",
                  Assets.icon.outline.clock),
              SizedBox(
                height: 16,
              ),
              _examInfoIconRow("۸ سوال", "نمره قبولی در آزمون",
                  Assets.icon.outlineTickCircle),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              boxShadow: DesignConfig.lowShadow,
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  text: "قبل از شروع آزمون به نکات زیر دقت فرمایید",
                  style: mThemeData.textTheme.titleBold,
                  color: Theme.of(context).primaryColor900()),
              SizedBox(
                height: 16,
              ),
              HighlightListView(
                items: [
                  "پس از اتمام زمان پاسخگویی شما قادر به جواب دادن به آزمون نمی‌باشید، پس زمان خود را مدیریت کنید.",
                  "آزمون شامل نمره منفی نمی‌باشد.",
                  "نتیجه آزمون در پایان آزمون به شما نمایش داده خواهد شد",
                  "برای رفتن به سوال بعدی روی گزینه‌ی “سوال بعدی” کلیک کنید",
                  "در صورت رد شدن در آزمون تا ۲ بار می‌توانید به صورت متوالی در آزمون شرکت کنید و بعد از مرحله آزمون تا ۲ ساعت برای شما قفل خواهد بود"
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _examInfoIconRow(String title, String subTitle, SvgGenImage icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
              child: icon.svg(width: 16, height: 16, color: secondaryColor)),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
                text: title,
                style: mThemeData.textTheme.titleBold,
                color: Theme.of(context).primaryColor900()),
            const SizedBox(
              height: 4,
            ),
            PrimaryText(
                text: subTitle,
                style: mThemeData.textTheme.rate,
                color: grayColor600),
          ],
        ),
      ],
    );
  }

}