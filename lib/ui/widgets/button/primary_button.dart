import 'package:flutter/material.dart';

import '../../theme/text/text_styles.dart';
import '../../theme/widget/app_buttons_style.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final bool fill;
  final double? height;

  const PrimaryButton(
      {super.key, required this.title, this.onClick, this.fill = false, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? MediaQuery.sizeOf(context).width : null,
      height: height,
      child: ElevatedButton(
          style: AppButtonsStyle.primaryButton,
          onPressed: onClick,
          child: Text(
            title,
            style: AppTextStyles.primaryButtonText,
          )),
    );
  }
}
