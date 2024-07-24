import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class CircleProgress extends StatelessWidget {
  final double value;
  final double strokeWidth;
  final double? width;
  final double? height;
  final String? text;
  final Color? color;
  final Color? backgroundColor;

  const CircleProgress(
      {super.key,
      required this.value,
      required this.strokeWidth,
      this.width,
      this.height,
      this.color,
      this.text,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).primaryColor;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
              child: CircularProgressIndicator(
            value: value,
            backgroundColor: backgroundColor ?? Theme.of(context).pinTextFont(),
            // borderRadius: DesignConfig.highBorderRadius,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(c),
          )),
          Center(
            child: PrimaryText(
                text: text ?? '',
                style: Theme.of(context).textTheme.navbarTitle,
                color: backgroundColor ?? Theme.of(context).pinTextFont()),
          )
        ],
      ),
    );
  }
}
