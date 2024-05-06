import 'dart:ui';

import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: AppTextStyles.pinPutTextStyle,
  decoration: BoxDecoration(
    border: Border.all(color: backgroundColor600),
    borderRadius: BorderRadius.circular(8),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: primaryColor),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    border: Border.all(color: primaryColor),
    borderRadius: BorderRadius.circular(8),
  ),
);
