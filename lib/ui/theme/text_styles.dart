import 'package:ajhman/ui/theme/colors.dart';
import 'package:flutter/material.dart';

const _defaultFontFamily = 'Dana';

class AppTextStyles {
  static TextStyle headerBoldWhite = headline3.copyWith(color: Colors.white);
  static TextStyle hintText = body1.copyWith(color: grayColor);
  static TextStyle errorText = body2.copyWith(color: errorMain);

  static TextStyle primaryButtonText = body1.copyWith(color: Colors.white);
  static TextStyle primaryTextFieldText = body1.copyWith(color: grayColor700);
  static TextStyle primaryTextFieldHint = body1.copyWith(color: grayColor200);

  static TextStyle pinPutTextStyle = body1.copyWith(color: grayColor800);
  static TextStyle navbarTitle = body5;

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
        fontFamily: _defaultFontFamily,
        fontSize: 18);
  }
}

//Headline
TextStyle headline1 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 24, fontFamily: _defaultFontFamily);
TextStyle headline2 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 20, fontFamily: _defaultFontFamily);
TextStyle headline3 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18, fontFamily: _defaultFontFamily);
TextStyle headline4 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, fontFamily: _defaultFontFamily);
TextStyle headline5 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 14, fontFamily: _defaultFontFamily);
TextStyle headline5Eng =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

TextStyle headline6 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 12, fontFamily: _defaultFontFamily);

//Headline

//Body
TextStyle body1 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    fontFamily: _defaultFontFamily);
TextStyle body1Eng =
    const TextStyle(fontWeight: FontWeight.normal, fontSize: 14);
TextStyle body2 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 14, fontFamily: _defaultFontFamily);
TextStyle body3 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    fontFamily: _defaultFontFamily);
TextStyle body3Eng = const TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 12,
);
TextStyle body4 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 12, fontFamily: _defaultFontFamily);
TextStyle body5 = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 10,
    fontFamily: _defaultFontFamily);
TextStyle body5Eng = const TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 10,
);
TextStyle body6 = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 10, fontFamily: _defaultFontFamily);
//Body

extension AppTextStyle on TextTheme {
  TextStyle get headerBold => headline3;

  TextStyle get headerLargeBold => headline3;

  TextStyle get dialogTitle => headline4;

  TextStyle get titleBold => headline5;
  TextStyle get titleBoldEng => headline5Eng;

  TextStyle get title => body1;
  TextStyle get titleEng => body1Eng;

  TextStyle get navbarTitle => body5;
  TextStyle get navbarTitleEng => body5Eng;

  TextStyle get navbarTitleBold => body6;

  TextStyle get searchHint => body3;
  TextStyle get searchHintEng => body3Eng;

  TextStyle get rate => body4;

  TextStyle get rateBold => headline4;
}
