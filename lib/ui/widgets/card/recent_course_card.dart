import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/model/cards/new_course_card_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../text/primary_text.dart';

class RecentCourseCard extends StatefulWidget {
  final int index;
  final EdgeInsetsGeometry? padding;
  final NewCourseCardModel response;
  final double? width;
  final double? height;


  const RecentCourseCard({super.key, required this.index, this.padding, required this.response, this.width, this.height});

  @override
  State<RecentCourseCard> createState() => _RecentCourseCardState();
}

class _RecentCourseCardState extends State<RecentCourseCard> {
  late NewCourseCardModel response;
  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final items = [1, 2, 3, 4];
    response = widget.response;
    final p = getProgressCard(response.progress.toString());



    return Center(
      child: Container(
        width: widget.width,
        height: widget.height,
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              boxShadow: DesignConfig.lowShadow,
              color: Theme.of(context).white()),
          padding: const EdgeInsets.all(8),
          margin: widget.padding?? EdgeInsets.zero,
          child:  Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _image(
                      getImageUrl(response.image)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
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
                          Container(
                            width: 100,
                            decoration:
                            BoxDecoration(boxShadow: DesignConfig.lowShadow),
                            child:  LinearProgress(value: p, minHeight: 8),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: 18,
                  left: 20,
                  child: PrimaryText(
                    text: p.toString().replaceAll(".", " / "),
                    style: Theme.of(context).textTheme.searchHint,
                    color: Theme.of(context).progressText(),
                  ))
            ],
          )),
    );
  }

  Column _infoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconInfo(icon: Assets.icon.outline.chart, desc: "سطح ${getLevel(response.level,false)}"),
        const SizedBox(
          height: 8,
        ),
        IconInfo(icon: Assets.icon.outline.note2, desc: response.category!.name.toString())
      ],
    );
  }

  Container _title(String text) {

    return Container(
      height: (Theme.of(context).textTheme.title.fontSize! * 3),
      constraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 190,
      ),
      child: PrimaryText(
        text: text,
        style: Theme.of(context).textTheme.title,
        textAlign: TextAlign.start,
        color: Theme.of(context).progressText(),
        maxLines: 2,
      ),
    );
  }

  Widget _image(String src) {
    return PrimaryImageNetwork(src: src, aspectRatio: 1/1);
  }
}
