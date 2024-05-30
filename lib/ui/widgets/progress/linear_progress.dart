import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';

class LinearProgress extends StatelessWidget{
  final double value;
  final double minHeight;

  const LinearProgress({super.key, required this.value, required this.minHeight});


  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: backgroundColor600,
      borderRadius: DesignConfig.highBorderRadius,
      minHeight: minHeight,
      valueColor: const AlwaysStoppedAnimation<Color>(primaryColor600),
    );
  }


}