import 'package:flutter/material.dart';

class AppColorsTheme {
  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: primaryColor800,
    brightness: Brightness.dark,
  );
}

extension AppColorScheme on ColorScheme{
  Color get appPrimary =>
      brightness == Brightness.light
          ? primaryColor
          : primaryColor;

  Color get secondary =>
      brightness == Brightness.light
          ? secondaryColor
          : secondaryColor;

  Color get tertiary =>
      brightness == Brightness.light
          ? tertiaryColor
          : tertiaryColor;

  Color get appBackground =>
      brightness == Brightness.light
          ? backgroundColor
          : backgroundColor900;

  Color get gray =>
      brightness == Brightness.light
          ? grayColor
          : grayColor;

  Color get warning =>
      brightness == Brightness.light
          ? warningMain
          : warningMain;

  Color get success =>
      brightness == Brightness.light
          ? successMain
          : successMain;

  Color get error =>
      brightness == Brightness.light
          ? errorMain
          : errorMain;

  Color get info =>
      brightness == Brightness.light
          ? infoMain
          : infoMain;

  Color get gold =>
      brightness == Brightness.light
          ? goldColor
          : goldColor;

  Color get silver =>
      brightness == Brightness.light
          ? silverColor
          : silverColor;

  Color get bronze =>
      brightness == Brightness.light
          ? bronzeColor
          : bronzeColor;

  Color get appOnBackground =>
      brightness == Brightness.light
          ? Colors.white
          : Colors.black;

  Color get appOnSurface =>
      brightness == Brightness.light
          ? grayColor
          : backgroundColor;



}


const primaryColorLight = primaryColor;
const primaryColorDark = Color(0xff444848);


const primaryColor50 = Color(0xffe6f2f2);
const primaryColor100 = Color(0xffb0d7d7);
const primaryColor200 = Color(0xff8ac4c4);
const primaryColor300 = Color(0xff55a9a9);
const primaryColor400 = Color(0xff349899);
const primaryColor = Color(0xff017e7f);
const primaryColor600 = Color(0xff017374);
const primaryColor700 = Color(0xff01595a);
const primaryColor800 = Color(0xff014546);
const primaryColor900 = Color(0xff014546);

//Secondary
const secondaryColor50 = Color(0xffede6f2);
const secondaryColor100 = Color(0xffc8b0d8);
const secondaryColor200 = Color(0xffad8ac5);
const secondaryColor300 = Color(0xff8855aa);
const secondaryColor400 = Color(0xff713499);
const secondaryColor = Color(0xff4d0180);
const secondaryColor600 = Color(0xff460174);
const secondaryColor700 = Color(0xff37015b);
const secondaryColor800 = Color(0xff2a0146);
const secondaryColor900 = Color(0xff200036);

//Tertiary
const tertiaryColor50 = Color(0xfffffbe6);
const tertiaryColor100 = Color(0xfffff3b0);
const tertiaryColor200 = Color(0xffffed8a);
const tertiaryColor300 = Color(0xffffe454);
const tertiaryColor400 = Color(0xffffdf33);
const tertiaryColor = Color(0xffffd700);
const tertiaryColor600 = Color(0xffe8c400);
const tertiaryColor700 = Color(0xffb59900);
const tertiaryColor800 = Color(0xff8c7600);
const tertiaryColor900 = Color(0xff6b5a00);

//Background
const backgroundColor50 = Color(0xfffdfefe);
const backgroundColor100 = Color(0xfffafbfb);
const backgroundColor200 = Color(0xfff7f9f9);
const backgroundColor300 = Color(0xfff4f6f6);
const backgroundColor400 = Color(0xfff1f4f4);
const backgroundColor = Color(0xffeef1f1);
const backgroundColor600 = Color(0xffd9dbdb);
const backgroundColor700 = Color(0xffa9abab);
const backgroundColor800 = Color(0xff838585);
const backgroundColor900 = Color(0xff646565);

//Gray
const grayColor50 = Color(0xfff2f3f3);
const grayColor100 = Color(0xffd6d9d9);
const grayColor200 = Color(0xffc3c6c6);
const grayColor300 = Color(0xffa7acac);
const grayColor400 = Color(0xff969c9c);
const grayColor = Color(0xff7c8383);
const grayColor600 = Color(0xff717777);
const grayColor700 = Color(0xff585d5d);
const grayColor800 = Color(0xff444848);
const grayColor900 = Color(0xff343737);

//Warning
const warningMain = Color(0xffEF6C00);
const warningBackground = Color(0xffFFF4E5);
const warningFont = Color(0xff663C00);

//Success
const successMain = Color(0xff5DBB63);
const successBackground = Color(0xffF1F8F1);
const successFont = Color(0xff265A29);

//Error
const errorMain = Color(0xffD32F2F);
const errorBackground = Color(0xffFDEDED);
const errorFont = Color(0xff5F2120);

//Info
const infoMain = Color(0xff0288D1);
const infoBackground = Color(0xffE5F6FD);
const infoFont = Color(0xff014361);

//Gold Silver Bronze
const goldColor = Color(0xffFFD700);
const silverColor = Color(0xffCDCDCD);
const bronzeColor = Color(0xffCD7F32);
