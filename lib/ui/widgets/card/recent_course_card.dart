import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/core/utils/language/bloc/language_bloc.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/args/course_main_args.dart';
import 'package:ajhman/data/model/language.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:ajhman/ui/widgets/text/marquee_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/new_course_card_model.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/colors.dart';
import '../../theme/design_config.dart';
import '../text/primary_text.dart';

class RecentCourseCard extends StatefulWidget {
  final int index;
  final EdgeInsetsGeometry? padding;
  final NewCourseCardModel response;
  final double? width;
  final double? height;

  const RecentCourseCard(
      {super.key,
      required this.index,
      this.padding,
      required this.response,
      this.width,
      this.height});

  @override
  State<RecentCourseCard> createState() => _RecentCourseCardState();
}

class _RecentCourseCardState extends State<RecentCourseCard> {
  late NewCourseCardModel response;
  bool isInternational = false;

  @override
  void initState() {
    response = widget.response;
    if (widget.response.tag != null && widget.response.tag == "international" ||
        context.read<LanguageBloc>().state.selectedLanguage ==
            Language.english) {
      setState(() {
        isInternational = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    response = widget.response;
    final p = getProgressCard(response.progress.toString());
    final progress = response.progress.toString().split('').reversed.join();

    return Center(
      child: InkWell(
        onTap: () {
          navigatorKey.currentState!.pushNamed(RoutePaths.courseMain,
              arguments: CourseMainArgs(
                  courseId: response.id,
                  catId: response.category!.id!,
                  tag: response.tag.toString()));
        },
        child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.lowShadow,
                color: Theme.of(context).white()),
            padding: const EdgeInsets.all(8),
            margin: widget.padding ?? EdgeInsets.zero,
            child: Stack(
              children: [
                Row(
                  children: [
                    _image(response.image.toString()),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _title(response.name.toString()),
                            const SizedBox(
                              height: 8,
                            ),
                            _infoes(),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: LinearProgress(value: p, minHeight: 8),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                PrimaryText(
                                  text: progress,
                                  style: Theme.of(context).textTheme.searchHint,
                                  color: Theme.of(context).progressText(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Column _infoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconInfo(
            icon: Assets.icon.outline.chart,
            desc: "سطح ${getLevel(response.level, false)}"),
        const SizedBox(
          height: 8,
        ),
        IconInfo(
            icon: Assets.icon.outline.note2,
            desc: response.category!.name.toString())
      ],
    );
  }

  Widget _title(String text) {
    return MarqueeText(
      text: text,
      style: isInternational
          ? Theme.of(context)
              .textTheme
              .titleEng
              .copyWith(color: Theme.of(context).progressText())
          : Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Theme.of(context).progressText()),
      stop: const Duration(microseconds: 2),
      textDirection: isInternational ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  Widget _image(String src) {
    return PrimaryImageNetwork(src: src, aspectRatio: 1 / 1);
  }
}
