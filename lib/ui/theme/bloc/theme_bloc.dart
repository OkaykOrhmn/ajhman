import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../color/colors.dart';
import '../theme_helper.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(AppColorsTheme.lightTheme) {
    on<ThemeEvent>((event, emit) async {
      //when app is started
      on<InitialThemeSetEvent>((event, emit) async {
        final bool hasDarkTheme = await isDark();
        if (hasDarkTheme) {
          emit(AppColorsTheme.darkTheme);
        } else {
          emit(AppColorsTheme.lightTheme);
        }
      });

      //while switch is clicked
      on<ThemeSwitchEvent>((event, emit) {
        final isDark = state == AppColorsTheme.darkTheme;
        emit(isDark ? AppColorsTheme.lightTheme : AppColorsTheme.darkTheme);
        setTheme(isDark);
      });
    });
  }
}
