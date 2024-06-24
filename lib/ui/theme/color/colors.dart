import 'package:flutter/material.dart';

extension ThemeDataApp on ThemeData {
  Color primaryColor50() {
    switch (this.primaryColor) {
      case pink:
        return pink50;
      case blue:
        return blue50;
      case purple:
        return purple50;
      default:
        return const Color(0xffe6f2f2);
    }
  }

  Color primaryColor100() {
    switch (this.primaryColor) {
      case pink:
        return pink100;
      case blue:
        return blue100;
      case purple:
        return purple100;
      default:
        return const Color(0xffb0d7d7);
    }
  }

  Color primaryColor200() {
    switch (this.primaryColor) {
      case pink:
        return pink200;
      case blue:
        return blue200;
      case purple:
        return purple200;
      default:
        return const Color(0xff8ac4c4);
    }
  }

  Color primaryColor300() {
    switch (this.primaryColor) {
      case pink:
        return pink300;
      case blue:
        return blue300;
      case purple:
        return purple300;
      default:
        return const Color(0xff55a9a9);
    }
  }

  Color primaryColor400() {
    switch (this.primaryColor) {
      case pink:
        return pink400;
      case blue:
        return blue400;
      case purple:
        return purple400;
      default:
        return const Color(0xff349899);
    }
  }

  Color primaryColor600() {
    switch (this.primaryColor) {
      case pink:
        return pink600;
      case blue:
        return blue600;
      case purple:
        return purple600;
      default:
        return const Color(0xff017374);
    }
  }

  Color primaryColor700() {
    switch (this.primaryColor) {
      case pink:
        return pink700;
      case blue:
        return blue700;
      case purple:
        return purple700;
      default:
        return const Color(0xff01595a);
    }
  }

  Color primaryColor800() {
    switch (this.primaryColor) {
      case pink:
        return pink800;
      case blue:
        return blue800;
      case purple:
        return purple800;
      default:
        return const Color(0xff014546);
    }
  }

  Color primaryColor900() {
    switch (this.primaryColor) {
      case pink:
        return pink900;
      case blue:
        return blue900;
      case purple:
        return purple900;
      default:
        return const Color(0xff014546);
    }
  }

  Color surfacePrimaryColor(){
    if(brightness == Brightness.light){
      return this.primaryColor;
    }else{
      return grayColor800;
    }
  }

  Color white(){
    if(brightness == Brightness.light){
      return Colors.white;
    }else{
      return grayColor800;
    }
  }

  Color black(){
    if(brightness == Brightness.light){
      return Colors.black;
    }else{
      return Colors.white;
    }
  }

  Color onWhite(){
    if(brightness == Brightness.light){
      return Color(0xffeef1f1);
    }else{
      return grayColor700;
    }
  }

  Color shadow(){
    if(brightness == Brightness.light){
      return grayColor900;
    }else{
      return backgroundColor100;
    }
  }

  Color disable(){
    if(brightness == Brightness.light){
      return backgroundColor600;
    }else{
      return grayColor600;
    }
  }

  Color editTextFilled(){
    if(brightness == Brightness.light){
      return backgroundColor100;
    }else{
      return grayColor800;
    }
  }

  Color editTextFont(){
    if(brightness == Brightness.light){
      return grayColor600;
    }else{
      return grayColor300;
    }
  }

  Color pinTextFont(){
    if(brightness == Brightness.light){
      return grayColor800;
    }else{
      return grayColor100;
    }
  }

  Color background(){
    if(brightness == Brightness.light){
      return Color(0xffeef1f1);
    }else{
      return grayColor900;
    }
  }

  Color cardBackground(){
    if(brightness == Brightness.light){
      return backgroundColor100;
    }else{
      return grayColor800;
    }
  }

  Color cardText(){
    if(brightness == Brightness.light){
      return grayColor700;
    }else{
      return grayColor50;
    }
  }

  Color progressText(){
    if(brightness == Brightness.light){
      return grayColor900;
    }else{
      return grayColor50;
    }
  }

  Color headText(){
    if(brightness == Brightness.light){
      return primaryColor900();
    }else{
      return grayColor50;
    }
  }

  Color headText2(){
    if(brightness == Brightness.light){
      return primaryColor800();
    }else{
      return primaryColor400();
    }
  }

  Color surfaceCard(){
    if(brightness == Brightness.light){
      return primaryColor50();
    }else{
      return grayColor400;
    }
  }

  Color secondaryColor(){
    if(brightness == Brightness.light){
      return secondaryColor600;
    }else{
      return secondaryColor200;
    }

  }

  Color placeholderBaseColor(){
    if(brightness == Brightness.light){
      return grayColor200;
    }else{
      return grayColor600;
    }
  }

  Color placeholderHighlightColor(){
    if(brightness == Brightness.light){
      return grayColor100;
    }else{
      return grayColor700;
    }
  }

  Color backgroundSuccess(){
    if(brightness == Brightness.light){
      return successBackground;
    }else{
      return successFont;
    }
  }
  Color backgroundError(){
    if(brightness == Brightness.light){
      return errorBackground;
    }else{
      return errorFont;
    }
  }
  Color fontSuccess(){
    if(brightness == Brightness.light){
      return successFont;
    }else{
      return successMain;
    }
  }
 Color fontError(){
    if(brightness == Brightness.light){
      return errorFont;
    }else{
      return errorMain;
    }
  }



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

const pink50 = Color(0xfffde9ef);
const pink100 = Color(0xfff8b9cf);
const pink200 = Color(0xfff598b7);
const pink300 = Color(0xfff06896);
const pink400 = Color(0xffed4b82);
const pink = Color(0xffe91e63);
const pink600 = Color(0xffd41b5a);
const pink700 = Color(0xffa51546);
const pink800 = Color(0xff801136);
const pink900 = Color(0xff620d2a);

const purple50 = Color(0xfff0ebf8);
const purple100 = Color(0xffd0c2e9);
const purple200 = Color(0xffb9a4de);
const purple300 = Color(0xff997bcf);
const purple400 = Color(0xff8561c5);
const purple = Color(0xff673ab7);
const purple600 = Color(0xff5e35a7);
const purple700 = Color(0xff492982);
const purple800 = Color(0xff392065);
const purple900 = Color(0xff2b184d);

const blue50 = Color(0xffeceef8);
const blue100 = Color(0xffc3c9e8);
const blue200 = Color(0xffa7afdd);
const blue300 = Color(0xff7e8acd);
const blue400 = Color(0xff6574c4);
const blue = Color(0xff3f51b5);
const blue600 = Color(0xff394aa5);
const blue700 = Color(0xff2d3a81);
const blue800 = Color(0xff232d64);
const blue900 = Color(0xff1a224c);

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
