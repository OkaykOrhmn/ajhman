import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme_helper.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: ThemeData(), fontSize: 1)) {
    on<ThemeEvent>((event, emit) async {
      if (event is InitialThemeSetEvent) {
        final bool hasDarkTheme = await isDark();
        final double fontSize = await getFontSize();
        final Color primary = await getPrimaryColor();
        isDarkTheme = hasDarkTheme;
        if (hasDarkTheme) {
          emit(ThemeState(
              themeData:
                  ThemeData(brightness: Brightness.dark, primaryColor: primary),
              fontSize: fontSize));
        } else {
          emit(ThemeState(
              themeData: ThemeData(
                  brightness: Brightness.light, primaryColor: primary),
              fontSize: fontSize));
        }
      }

      if (event is ThemeSwitchEvent) {
        final bool hasDarkTheme = await isDark();
        final Color primary = await getPrimaryColor();
        emit(hasDarkTheme
            ? ThemeState(
                themeData: ThemeData(
                    brightness: Brightness.light, primaryColor: primary),
                fontSize: state.fontSize)
            : ThemeState(
                themeData: ThemeData(
                    brightness: Brightness.dark, primaryColor: primary),
                fontSize: state.fontSize));
        setTheme(hasDarkTheme);
        isDarkTheme = hasDarkTheme;
      }

      if (event is ThemeSizeEvent) {
        emit(ThemeState(themeData: state.themeData, fontSize: event.fontSize));
        setFontSize(event.fontSize);
      }

      if (event is ThemePrimaryEvent) {
        final bool hasDarkTheme = await isDark();
        emit(hasDarkTheme
            ? ThemeState(
                themeData: ThemeData(
                    brightness: Brightness.dark, primaryColor: event.color),
                fontSize: state.fontSize)
            : ThemeState(
                themeData: ThemeData(
                    brightness: Brightness.light, primaryColor: event.color),
                fontSize: state.fontSize));
        setPrimaryColorTheme(event.color.value);
      }
    });
  }
}
