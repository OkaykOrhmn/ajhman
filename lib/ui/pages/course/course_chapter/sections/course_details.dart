import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/bloc/chapter/chapter_bloc.dart';
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
    final data = context.read<SubChapterCubit>().state!.chapterModel;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: backgroundColor100,
              borderRadius: DesignConfig.highBorderRadius,
              boxShadow: DesignConfig.lowShadow
          ),
          child: Column(
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
                  items: data.highlight!,
              )
            ],
          ),
        ),
        Stack(
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
                          data.description.toString(),
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
                                  .svg(width: 24, height: 24, color: Theme.of(context).primaryColor)
                              : Assets.icon.outline.arrowDown
                                  .svg(width: 24, height: 24, color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
