import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../widgets/listview/highlight_listview.dart';

class CourseDetails extends StatefulWidget {
  final bool eng;
  const CourseDetails({super.key, this.eng = false});

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
        // Container(
        //   padding: const EdgeInsets.all(16),
        //   margin: const EdgeInsets.all(16),
        //   decoration: BoxDecoration(
        //       color: Theme.of(context).cardBackground(),
        //       borderRadius: DesignConfig.highBorderRadius,
        //       boxShadow: DesignConfig.lowShadow),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       PrimaryText(
        //         text: widget.eng
        //             ? "What we learn in this course"
        //             : "آنچه در این دوره می‌آموزیم",
        //         style: Theme.of(context).textTheme.dialogTitle,
        //         color: Theme.of(context).headText(),
        //         textAlign: TextAlign.start,
        //       ),
        //       const SizedBox(
        //         height: 16,
        //       ),
        //       HighlightListView(
        //         items: data.highlight!,
        //       )
        //     ],
        //   ),
        // ),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16)
                  .copyWith(bottom: _showMore ? 48 : 16),
              decoration: BoxDecoration(
                  boxShadow: DesignConfig.lowShadow,
                  color: Theme.of(context).white(),
                  borderRadius: DesignConfig.highBorderRadius),
              child: Column(
                children: [
                  TitleDivider(
                    title: widget.eng ? "Session Description" : "توضیحات جلسه",
                    hasPadding: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: _showMore
                            ? double.infinity
                            : (Theme.of(context).textTheme.title.fontSize! * 6),
                      ),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: HtmlWidget(
                          data.description.toString(),
                          textStyle: Theme.of(context).textTheme.title.copyWith(
                                color: Theme.of(context).headText(),
                              ),
                        ),
                      ),
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
                  height: 64,
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
