import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/states/default_place_holder.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../theme/colors.dart';
import '../../theme/design_config.dart';
import '../text/primary_text.dart';

class RecentCourseCardPlaceholder extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const RecentCourseCardPlaceholder({
    super.key,
    this.padding,
    this.width,
    this.height,
  });

  @override
  State<RecentCourseCardPlaceholder> createState() => _RecentCourseCardState();
}

class _RecentCourseCardState extends State<RecentCourseCardPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultPlaceHolder(
                    child: _image(""),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DefaultPlaceHolder(
                              child: SizedBox(
                            width: 160,
                            height: 12,
                          )),
                          const SizedBox(height: 24),
                          _infoes(),
                          const SizedBox(
                            height: 24,
                          ),
                          DefaultPlaceHolder(
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  boxShadow: DesignConfig.lowShadow),
                              child: const LinearProgress(
                                  value: 0.8, minHeight: 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Positioned(
              //     bottom: 18,
              //     left: 20,
              //     child: DefaultPlaceHolder(
              //       child: PrimaryText(
              //         text: "response.progress.toString()",
              //         style: mThemeData.textTheme.searchHint,
              //         color: grayColor900,
              //       ),
              //     ))
            ],
          )),
    );
  }

  Column _infoes() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultPlaceHolder(
            child: SizedBox(
          width: 100,
          height: 12,
        )),
        SizedBox(
          height: 8,
        ),
        DefaultPlaceHolder(
            child: SizedBox(
          width: 100,
          height: 12,
        )),
      ],
    );
  }

  Container _title(String text) {
    return Container(
      child: PrimaryText(
        text: text,
        style: mThemeData.textTheme.title,
        textAlign: TextAlign.start,
        color: Theme.of(context).progressText(),
        maxLines: 2,
      ),
    );
  }

  Widget _image(String src) {
    return PrimaryImageNetwork(src: src, aspectRatio: 1 / 1);
  }
}
