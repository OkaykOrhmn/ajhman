import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';

class CircleProgress extends StatelessWidget {
  final double value;
  final double strokeWidth;
  final double? width;
  final double? height;
  final String? text;
  final Color? color;

   const CircleProgress(
      {super.key,
      required this.value,
      required this.strokeWidth,
      this.width,
      this.height,
      this.color, this.text});

  @override
  Widget build(BuildContext context) {
    final c = color?? Theme.of(context).primaryColor;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(child: CircularProgressIndicator(
            value: value,
            backgroundColor: c.withOpacity(0.2),
            // borderRadius: DesignConfig.highBorderRadius,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(c),
          )),
          Center(child: PrimaryText(text: text?? '', style: mThemeData.textTheme.searchHint, color: grayColor800),)
        ],
      ),
    );
  }
}
