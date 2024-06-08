import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/carousel/carousel_course_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../theme/color/colors.dart';
import '../../../../widgets/listview/highlight_listview.dart';
import '../../../../widgets/text/primary_text.dart';

class CourseText extends StatefulWidget {
  const CourseText({super.key});

  @override
  State<CourseText> createState() => _CourseTextState();
}

class _CourseTextState extends State<CourseText> {
  final highlight = [
    "data.highlight",
    "data.highlight",
    "data.highlight",
    "data.highlight",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              items: highlight,
              item: (index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.circle,
                          size: 8,
                          color: grayColor600,
                        ),
                      ),
                      PrimaryText(
                          text: highlight![index],
                          style: mThemeData.textTheme.title,
                          color: grayColor600)
                    ],
                  ))
        ],
      ),
    );
  }
}
