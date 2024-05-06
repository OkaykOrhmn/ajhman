import 'dart:ui';

import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const defaultFontFamily = 'Dana';

  static TextStyle headerBoldWhite = headline3.copyWith(color: Colors.white);
  static TextStyle hintText = body1.copyWith(color: grayColor);
  static TextStyle errorText = body2.copyWith(color: errorMain);

  static TextStyle primaryButtonText = body1.copyWith(color: Colors.white);
  static TextStyle primaryTextFieldText = body1.copyWith(color: grayColor700);
  static TextStyle primaryTextFieldHint = body1.copyWith(color: grayColor200);

  static TextStyle pinPutTextStyle = body1.copyWith(color: grayColor800);

  static TextStyle outlinedPrimaryButtonText =
      body1.copyWith(color: primaryColor);

  static TextStyle linkPrimaryTextButtonText =
      body1.copyWith(color: primaryColor);

  static TextStyle descWelcomeDialogSmartSchedule =
      body1.copyWith(color: grayColor800);

  static TextStyle headerBoldDynamic(ThemeData themeData) {
    return TextStyle(
        color: themeData.colorScheme.onBackground,
        fontWeight: FontWeight.bold,
        fontFamily: defaultFontFamily,
        fontSize: 18);
  }

  //Headline
  static TextStyle headline1 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 24, fontFamily: defaultFontFamily);
  static TextStyle headline2 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, fontFamily: defaultFontFamily);
  static TextStyle headline3 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, fontFamily: defaultFontFamily);
  static TextStyle headline4 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, fontFamily: defaultFontFamily);
  static TextStyle headline5 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 14, fontFamily: defaultFontFamily);

  //Headline

  //Body
  static TextStyle body1 = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      fontFamily: defaultFontFamily);
  static TextStyle body2 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 14, fontFamily: defaultFontFamily);
  static TextStyle body3 = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      fontFamily: defaultFontFamily);
  static TextStyle body4 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 12, fontFamily: defaultFontFamily);
  static TextStyle body5 = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10,
      fontFamily: defaultFontFamily);
  static TextStyle body6 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 10, fontFamily: defaultFontFamily);
//Body
}
