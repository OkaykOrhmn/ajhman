part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class InitialThemeSetEvent extends ThemeEvent {}

class ThemeSwitchEvent extends ThemeEvent {}

class ThemePrimaryEvent extends ThemeEvent {
  final Color color;

  ThemePrimaryEvent({required this.color});
}

class ThemeSizeEvent extends ThemeEvent {
  final double fontSize;

  ThemeSizeEvent({required this.fontSize});
}
