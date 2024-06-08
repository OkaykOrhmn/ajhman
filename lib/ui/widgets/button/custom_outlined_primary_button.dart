import 'package:flutter/material.dart';

import '../../theme/text/text_styles.dart';
import '../../theme/widget/app_buttons_style.dart';

class CustomOutlinedPrimaryButton extends StatelessWidget {
  final Widget child;
  final Function()? onClick;
  final bool fill;

  const CustomOutlinedPrimaryButton(
      {super.key, required this.child, this.onClick, this.fill = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? MediaQuery.sizeOf(context).width : null,
      child: OutlinedButton(
          style: AppButtonsStyle.outlinedPrimaryButton,
          onPressed: onClick,
          child: Center(
            child: child,
          )),
    );
  }
}
