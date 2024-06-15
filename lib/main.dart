import 'package:ajhman/core/bloc/category/category_bloc.dart';
import 'package:ajhman/core/bloc/chapter/chapter_bloc.dart';
import 'package:ajhman/core/bloc/comments/comments_bloc.dart';
import 'package:ajhman/core/bloc/for_you/for_you_bloc.dart';
import 'package:ajhman/core/bloc/profile/profile_bloc.dart';
import 'package:ajhman/core/bloc/roadmap/roadmap_bloc.dart';
import 'package:ajhman/core/bloc/search/search_bloc.dart';
import 'package:ajhman/core/bloc/treasure/treasure_bloc.dart';
import 'package:ajhman/core/cubit/audio/audio_player_cubit.dart';
import 'package:ajhman/core/cubit/answer/answer_cubit.dart';
import 'package:ajhman/core/cubit/home/news_course_home_cubit.dart';
import 'package:ajhman/core/cubit/learn/selected_tab_cubit.dart';
import 'package:ajhman/core/cubit/search/search_cubit.dart';
import 'package:ajhman/core/cubit/summery/summery_cubit.dart';
import 'package:ajhman/core/cubit/video/video_player_cubit.dart';
import 'package:ajhman/core/routes/route_paths.dart';

import 'package:ajhman/ui/theme/bloc/theme_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/bloc/auth/auth_screen_bloc.dart';
import 'core/bloc/course/main/course_main_bloc.dart';
import 'core/bloc/learning/leaning_bloc.dart';
import 'core/bloc/otp/otp_bloc.dart';
import 'core/bloc/pin/pin_bloc.dart';
import 'core/bloc/smart_schedule/smart_schedule_bloc.dart';
import 'core/bloc/ticker/timer_bloc.dart';
import 'core/cubit/home/selected_index_cubit.dart';
import 'core/cubit/timer/timer_cubit.dart';
import 'core/routes/route_generator.dart';
import 'core/utils/app_locale.dart';
import 'core/utils/language/bloc/language_bloc.dart';
import 'core/utils/timer/ticker.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final BuildContext mContext = navigatorKey.currentContext!;
final ThemeData mThemeData = Theme.of(mContext);

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
    BlocProvider<ProfileBloc>(
      create: (buildContext) {
        final bloc = ProfileBloc();
        return bloc;
      },
    ),
    BlocProvider<CourseMainBloc>(
      create: (buildContext) {
        final bloc = CourseMainBloc();
        return bloc;
      },
    ),
    BlocProvider<CommentsBloc>(
      create: (buildContext) {
        final bloc = CommentsBloc();
        return bloc;
      },
    ),
    BlocProvider<CategoryBloc>(
      create: (buildContext) {
        final bloc = CategoryBloc();
        return bloc;
      },
    ),
    BlocProvider<ChapterBloc>(
      create: (buildContext) {
        final bloc = ChapterBloc();
        return bloc;
      },
    ),

    BlocProvider<RoadmapBloc>(
      create: (buildContext) {
        final bloc = RoadmapBloc();
        return bloc;
      },
    ),

    BlocProvider<LeaningBloc>(
      create: (buildContext) {
        final bloc = LeaningBloc();
        return bloc;
      },
    ),
    BlocProvider<ForYouBloc>(
      create: (buildContext) {
        final bloc = ForYouBloc();
        return bloc;
      },
    ),
    BlocProvider<TreasureBloc>(
      create: (buildContext) {
        final bloc = TreasureBloc();
        return bloc;
      },
    ),
    BlocProvider<SearchBloc>(
      create: (buildContext) {
        final bloc = SearchBloc();
        return bloc;
      },
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
      create: (context) => SummeryCubit(),
    ),
    BlocProvider(
      create: (context) => NewsCourseHomeCubit(),
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
  void initState() {
    super.initState();
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
              navigatorKey: navigatorKey,
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
              initialRoute: RoutePaths.splash,
              onGenerateRoute: (settings) =>
                  RouteGenerator.destination(settings),
            );
          },
        );
      },
    );
  }
}
