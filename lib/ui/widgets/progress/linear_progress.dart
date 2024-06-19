import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';

class LinearProgress extends StatelessWidget {
  final double value;
  final double minHeight;
  final Color? backgroundColor;
  final Color? valueColor;

  const LinearProgress(
      {super.key,
      required this.value,
      required this.minHeight,
      this.backgroundColor,
      this.valueColor});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: backgroundColor ?? backgroundColor600,
      borderRadius: DesignConfig.highBorderRadius,
      minHeight: minHeight,
      valueColor: AlwaysStoppedAnimation<Color>(valueColor ?? Theme.of(context).primaryColor600()),
    );
  }
}
