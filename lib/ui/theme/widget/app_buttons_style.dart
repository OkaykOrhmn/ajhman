import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/material.dart';

import '../color/colors.dart';

class AppButtonsStyle {
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));

  static ButtonStyle outlinedPrimaryButton = OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: const BorderSide(color: primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ));

  static ButtonStyle linkPrimaryTextButton = OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      textStyle: AppTextStyles.linkPrimaryTextButtonText);
}
