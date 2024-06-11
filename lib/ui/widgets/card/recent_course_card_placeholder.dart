import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
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

class RecentCourseCardPlaceholder extends StatefulWidget {
  final EdgeInsetsGeometry? padding;


  const RecentCourseCardPlaceholder({super.key, this.padding,});

  @override
  State<RecentCourseCardPlaceholder> createState() => _RecentCourseCardState();
}

class _RecentCourseCardState extends State<RecentCourseCardPlaceholder> {
  @override
  Widget build(BuildContext context) {



    return Center(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              boxShadow: DesignConfig.defaultShadow,
              color: Colors.white),
          padding: const EdgeInsets.all(8),
          margin: widget.padding?? EdgeInsets.zero,
          child:  Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultPlaceHolder(
                    child: _image(
                        ""),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultPlaceHolder(child: _title("response.name.toString()")),
                          const SizedBox(
                            height: 8,
                          ),
                          _infoes(),
                          const SizedBox(
                            height: 8,
                          ),
                          DefaultPlaceHolder(
                            child: Container(
                              width: 100,
                              decoration:
                              BoxDecoration(boxShadow: DesignConfig.defaultShadow),
                              child:  LinearProgress(value: 0.8, minHeight: 8),
                            ),
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
                  child: DefaultPlaceHolder(
                    child: PrimaryText(
                      text: "response.progress.toString()",
                      style: mThemeData.textTheme.searchHint,
                      color: grayColor900,
                    ),
                  ))
            ],
          )),
    );
  }

  Column _infoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultPlaceHolder(child: Container(width: 100,height: 12,)),
        const SizedBox(
          height: 8,
        ),
        DefaultPlaceHolder(child: Container(width: 100,height: 12,)),
      ],
    );
  }

  Container _title(String text) {

    return Container(
      child: PrimaryText(
        text: text,
        style: mThemeData.textTheme.title,
        textAlign: TextAlign.start,
        color: grayColor900,
        maxLines: 2,
      ),
    );
  }

  Widget _image(String src) {
    return PrimaryImageNetwork(src: src, aspectRatio: 1/1);
  }
}
