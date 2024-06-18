part of 'theme_bloc.dart';

// @immutable
// sealed class ThemeState {}
//
// final class ThemeInitial extends ThemeState {}

class ThemeState {
  final ThemeData themeData;
  final double fontSize;

  ThemeState({required this.themeData, required this.fontSize});
}

