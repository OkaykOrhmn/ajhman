import 'package:flutter/material.dart';

import '../../theme/text/text_styles.dart';
import '../../theme/widget/app_buttons_style.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final bool fill;

  const OutlinedPrimaryButton(
      {super.key, required this.title, this.onClick, this.fill = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? MediaQuery.sizeOf(context).width : null,
      child: OutlinedButton(
          style: AppButtonsStyle.outlinedPrimaryButton,
          onPressed: onClick,
          child: Text(
            title,
            style: AppTextStyles.outlinedPrimaryButtonText,
          )),
    );
  }
}
