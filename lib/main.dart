import 'package:ajhman/data/bloc/otp/otp_bloc.dart';
import 'package:ajhman/data/bloc/pin/pin_bloc.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/data/bloc/auth/auth_screen_bloc.dart';
import 'package:ajhman/data/bloc/smart_schedule/smart_schedule_bloc.dart';
import 'package:ajhman/ui/pages/home/home_page.dart';
import 'package:ajhman/ui/theme/bloc/theme_bloc.dart';
import 'package:ajhman/utils/app_locale.dart';
import 'package:ajhman/utils/language/bloc/language_bloc.dart';
import 'package:ajhman/utils/timer/Ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'data/bloc/ticker/timer_bloc.dart';

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
    BlocProvider<OtpBloc>(
      create: (buildContext) {
        final bloc = OtpBloc();
        return bloc;
      },
    ),
    BlocProvider<PinBloc>(
      create: (buildContext) {
        final bloc = PinBloc();
        return bloc;
      },
    ),
    BlocProvider<TimerBloc>(
      create: (buildContext) {
        final bloc = TimerBloc(ticker: const Ticker());
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
  Future<Widget> _getMainScreen() async {
    final token = await getToken();
    if (token.isEmpty) {
      return const AuthPageStarted();
    } else {
      return const HomePage();
    }
  }

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
              home: FutureBuilder(
                  future: _getMainScreen(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            );
          },
        );
      },
    );
  }
}
