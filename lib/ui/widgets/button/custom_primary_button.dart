import 'package:flutter/material.dart';

import '../../theme/color/colors.dart';
import '../../theme/text/text_styles.dart';
import '../../theme/widget/app_buttons_style.dart';
import '../../theme/widget/design_config.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Function()? onClick;
  final bool fill;
  final double? height;
  final Widget child;
  final Color? color;
  final double? elevation;

  const CustomPrimaryButton(
      {super.key,
      this.onClick,
      this.fill = false,
      this.height,
      required this.child,
      this.color, this.elevation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? MediaQuery.sizeOf(context).width : null,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color ?? primaryColor,
              foregroundColor: color == null ? secondaryColor : primaryColor,
              elevation: elevation,
              shape: const RoundedRectangleBorder(
                  borderRadius: DesignConfig.mediumBorderRadius)),

          onPressed: onClick,
          child: child),
    );
  }
}
