import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';

class CircleProgress extends StatelessWidget{
  final double value;
  final double strokeWidth;

  const CircleProgress({super.key, required this.value, required this.strokeWidth});


  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      backgroundColor: backgroundColor600,

      // borderRadius: DesignConfig.highBorderRadius,
      strokeWidth: strokeWidth,
      valueColor: const AlwaysStoppedAnimation<Color>(primaryColor600),
    );
  }


}