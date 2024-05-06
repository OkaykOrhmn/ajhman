import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/data/bloc/auth/auth_screen_bloc.dart';
import 'package:ajhman/data/bloc/smart_schedule/smart_schedule_bloc.dart';
import 'package:ajhman/ui/theme/bloc/theme_bloc.dart';
import 'package:ajhman/utils/app_locale.dart';
import 'package:ajhman/utils/language/bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBloc>(
      create: (buildContext) {
        final bloc = ThemeBloc();
        bloc.add(InitialThemeSetEvent());
        return bloc;
      },
    ),
    BlocProvider<LanguageBloc>(
      create: (buildContext) {
        final bloc = LanguageBloc();
        return bloc;
      },
    ),
    BlocProvider<SmartScheduleBloc>(
      create: (buildContext) {
        final bloc = SmartScheduleBloc();
        bloc.add(SmartScheduleToCalender());
        return bloc;
      },
    ),

    BlocProvider<AuthScreensBloc>(
      create: (buildContext) {
        final bloc = AuthScreensBloc();
        bloc.add(AuthNavigateOtpEvent());
        return bloc;
      },
    ),

  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ChangeLocale changeLocale = ChangeLocale(context);
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, state) {
        ThemeData themeData = state;
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              locale: state.selectedLanguage.value,
              // Set the locale you want the app to display messages
              localizationsDelegates: const [
                AppLocalizations.delegate, // Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                // English
                Locale('fa'),
                // farsi
                // Add more supported locales based on your application's target audience
              ],
              theme: themeData,
              home: AuthPageStarted(),
            );
          },
        );
      },
    );
  }
}
