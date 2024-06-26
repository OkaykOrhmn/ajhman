import 'package:ajhman/core/bloc/profile/profile_bloc.dart';
import 'package:ajhman/core/cubit/audio/audio_player_cubit.dart';
import 'package:ajhman/core/cubit/answer/answer_cubit.dart';
import 'package:ajhman/core/cubit/download/download_cubit.dart';
import 'package:ajhman/core/cubit/home/news_course_home_cubit.dart';
import 'package:ajhman/core/cubit/learn/selected_tab_cubit.dart';
import 'package:ajhman/core/cubit/video/video_player_cubit.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/core/services/firebase_api.dart';
import 'package:ajhman/core/services/notification_service.dart';
import 'package:ajhman/firebase_options.dart';

import 'package:ajhman/ui/theme/bloc/theme_bloc.dart';
import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/bloc/chapter/chapter_bloc.dart';
import 'core/bloc/questions/questions_bloc.dart';
import 'core/bloc/ticker/timer_bloc.dart';
import 'core/cubit/home/selected_index_cubit.dart';
import 'core/cubit/image_picker/image_picker_cubit.dart';
import 'core/cubit/timer/timer_cubit.dart';
import 'core/routes/route_generator.dart';
import 'core/utils/app_locale.dart';
import 'core/utils/language/bloc/language_bloc.dart';
import 'core/utils/timer/timer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ThemeData mThemeData = Theme.of(navigatorKey.currentContext!);
String token = '';
double fontSize = 1;
bool isDarkTheme =
    SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;

// @pragma('vm:entry-point')
Future _initPushNotification(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    FirebaseMessaging.onBackgroundMessage(_initPushNotification);
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseApi().initNotification();
    await NotificationService.initializeNotification();
  } catch (e) {
    rethrow;
  }

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
    BlocProvider<ConnectivityBloc>(
      create: (buildContext) {
        final bloc = ConnectivityBloc();
        return bloc;
      },
    ),
    BlocProvider<TimerBloc>(
      create: (buildContext) {
        final bloc = TimerBloc(ticker: const Timer());
        return bloc;
      },
    ),
    BlocProvider<ProfileBloc>(
      create: (buildContext) {
        final bloc = ProfileBloc();
        return bloc;
      },
    ),
    BlocProvider<QuestionsBloc>(
      create: (buildContext) {
        final bloc = QuestionsBloc();
        // bloc.add(GetAllQuestions(id: data.id!));
        return bloc;
      },
    ),
    BlocProvider<ChapterBloc>(
      create: (buildContext) {
        final bloc = ChapterBloc();
        return bloc;
      },
    ),
    BlocProvider(
      create: (context) => ImagePickerCubit(),
    ),
    BlocProvider(
      create: (context) => SelectedIndexCubit(),
    ),
    BlocProvider(
      create: (context) => SelectedTabCubit(),
    ),
    BlocProvider(
      create: (context) => VideoPlayerCubit(),
    ),
    BlocProvider(
      create: (context) => AudioPlayerCubit(),
    ),
    BlocProvider(
      create: (context) => TimerCubit(),
    ),
    BlocProvider(
      create: (context) => AnswerCubit(),
    ),
    BlocProvider(
      create: (context) => NewsCourseHomeCubit(),
    ),
    BlocProvider(
      create: (context) => DownloadCubit(),
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        ThemeData themeData = state.themeData;
        if (navigatorKey.currentContext != null) {
          context = navigatorKey.currentContext!;
        }
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, lang) {
            // return BlocBuilder<ConnectivityBloc, ConnectivityState>(
            //   builder: (context, state) {
            //     if (state is ConnectivitySuccessState ||
            //         state is ConnectivityInitialState) {
            return MaterialApp(
              theme: themeData,
              navigatorKey: navigatorKey,
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              locale: lang.selectedLanguage.value,
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
              // home: const SplashPage(),
              initialRoute: RoutePaths.splash,
              onGenerateRoute: (settings) =>
                  RouteGenerator.destination(settings),
            );
            // } else if (state is ConnectivityFailureState) {
            //   return NoConnectivityScreen(
            //     themeData: themeData,
            //   );
            // } else {
            //   return SizedBox();
            // }
          },
          // );
          // },
        );
      },
    );
  }
}
