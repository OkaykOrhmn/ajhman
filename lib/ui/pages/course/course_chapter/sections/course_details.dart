import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../widgets/listview/highlight_listview.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({super.key});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    final data = context.read<SubChapterCubit>().state.chapterModel;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).cardBackground(),
              borderRadius: DesignConfig.highBorderRadius,
              boxShadow: DesignConfig.lowShadow),
          child: Column(
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
              HighlightListView(
                items: data.highlight!,
              )
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16).copyWith(bottom: _showMore ? 48 : 16),
              decoration: BoxDecoration(
                  boxShadow: DesignConfig.lowShadow,
                  color: Theme.of(context).white(),
                  borderRadius: DesignConfig.highBorderRadius),
              child: Column(
                children: [
                  const TitleDivider(
                    title: "توضیحات جلسه",
                    hasPadding: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: PrimaryText(
                      text: data.description.toString(),
                      style: Theme.of(context).textTheme.title,
                      color: Theme.of(context).progressText(),
                      textAlign: TextAlign.justify,
                      maxLines: _showMore ? null : 10,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 16,
                right: 16,
                child: Container(
                  height: 90,
                  alignment: Alignment.bottomCenter,
                  decoration: _showMore
                      ? null
                      : BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: DesignConfig.aHighBorderRadius,
                              bottomRight: DesignConfig.aHighBorderRadius),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).white().withOpacity(0.8),
                              Theme.of(context).white().withOpacity(0.9),
                              Theme.of(context).white(),
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
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor50()),
                      width: 40,
                      height: 40,
                      child: Center(
                          child: _showMore
                              ? Assets.icon.outline.arrowUp.svg(
                                  width: 24,
                                  height: 24,
                                  color: Theme.of(context).primaryColor)
                              : Assets.icon.outline.arrowDown.svg(
                                  width: 24,
                                  height: 24,
                                  color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
