import 'package:ajhman/core/cubit/subchapter/sub_chapter_cubit.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/progress/circle_progress.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseHeader extends StatefulWidget {
  final String title;
  final bool eng;
  const CourseHeader({super.key, required this.title, this.eng = false});

  @override
  State<CourseHeader> createState() => _CourseHeaderState();
}

class _CourseHeaderState extends State<CourseHeader> {
  @override
  Widget build(BuildContext context) {
    final data = context.read<SubChapterCubit>().state.chapterModel;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: DesignConfig.highBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                  text: widget.title,
                  style: Theme.of(context).textTheme.titleBold,
                  color: CupertinoColors.white),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: DesignConfig.highBorderRadius,
                    color: Colors.white.withOpacity(0.8)),
                child: Row(
                  children: [
                    PrimaryText(
                        text: "4.2",
                        style: widget.eng
                            ? Theme.of(context).textTheme.searchHintEng
                            : Theme.of(context).textTheme.searchHint,
                        color: Colors.black),
                    const SizedBox(
                      width: 2,
                    ),
                    const Icon(
                      CupertinoIcons.star_fill,
                      color: goldColor,
                      size: 16,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).cardBackground(),
              borderRadius: DesignConfig.highBorderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleProgress(
                value: 0.8,
                strokeWidth: 4,
                width: 32,
                height: 32,
              ),
              const SizedBox(
                width: 16,
              ),
              PrimaryText(
                  text: widget.eng
                      ? "You have viewed 67% of the course"
                      : "شما ۶۷ درصد از دوره را مشاهده کرده‌اید.",
                  style: widget.eng
                      ? Theme.of(context).textTheme.titleEng
                      : Theme.of(context).textTheme.title,
                  color: Theme.of(context).cardText()),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        PrimaryText(
            text: data.name.toString(),
            style: Theme.of(context).textTheme.titleBold,
            color: Theme.of(context).headText()),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
