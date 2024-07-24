import 'package:ajhman/data/args/exam_args.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../theme/colors.dart';
import '../../../theme/design_config.dart';
import '../../../widgets/listview/highlight_listview.dart';
import '../../../widgets/text/primary_text.dart';

class ExamInfoScreen extends StatefulWidget {
  final String comment;
  final ExamArgs examArgs;
  const ExamInfoScreen(
      {super.key, required this.comment, required this.examArgs});

  @override
  State<ExamInfoScreen> createState() => _ExamInfoScreenState();
}

class _ExamInfoScreenState extends State<ExamInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryText(
            text: "آزمون",
            style: Theme.of(context).textTheme.dialogTitle,
            color: Theme.of(context).headText()),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              color: Theme.of(context).white()),
          child: Column(
            children: [
              _examInfoIconRow("${widget.examArgs.model.exam!.length} سوال",
                  "سوال ۴ گزینه‌ای", Assets.icon.outline.task),
              const SizedBox(
                height: 16,
              ),
              _examInfoIconRow(
                  "${widget.examArgs.model.exam!.length * 2} دقیقه",
                  "زمان پاسخگویی به سوال",
                  Assets.icon.outline.clock),
              const SizedBox(
                height: 16,
              ),
              _examInfoIconRow(
                  "${((widget.examArgs.model.exam!.length * 80) / 100).round()} سوال",
                  "نمره قبولی در آزمون",
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
              color: Theme.of(context).white()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  text: "قبل از شروع آزمون به نکات زیر دقت فرمایید",
                  style: Theme.of(context).textTheme.titleBold,
                  color: Theme.of(context).headText()),
              const SizedBox(
                height: 16,
              ),
              const HighlightListView(
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
          decoration: BoxDecoration(
            color: Theme.of(context).white(),
            shape: BoxShape.circle,
          ),
          child: Center(
              child: icon.svg(
                  width: 16,
                  height: 16,
                  color: Theme.of(context).secondaryColor())),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
                text: title,
                style: Theme.of(context).textTheme.titleBold,
                color: Theme.of(context).headText()),
            const SizedBox(
              height: 4,
            ),
            PrimaryText(
                text: subTitle,
                style: Theme.of(context).textTheme.rate,
                color: Theme.of(context).editTextFont()),
          ],
        ),
      ],
    );
  }
}
