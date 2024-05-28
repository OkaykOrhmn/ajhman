import 'package:flutter/material.dart';

import '../../theme/text/text_styles.dart';
import '../../theme/widget/app_buttons_style.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onClick;

  const OutlinedPrimaryButton({super.key, required this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: AppButtonsStyle.outlinedPrimaryButton,
        onPressed: onClick,
        child: Text(
          title,
          style: AppTextStyles.outlinedPrimaryButtonText,
        ));
  }
}
