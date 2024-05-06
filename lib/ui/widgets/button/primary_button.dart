import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/text/text_styles.dart';
import '../../theme/widget/app_buttons_style.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onClick;

  PrimaryButton({required this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: AppButtonsStyle.primaryButton,
        onPressed: onClick,
        child: Text(
          title,
          style: AppTextStyles.primaryButtonText,
        ));
  }
}
