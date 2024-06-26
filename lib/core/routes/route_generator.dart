import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/data/args/category_args.dart';
import 'package:ajhman/data/args/course_main_args.dart';
import 'package:ajhman/data/args/exam_args.dart';
import 'package:ajhman/data/model/answer_result_model.dart';
import 'package:ajhman/data/model/leaderboard_model.dart';
import 'package:ajhman/ui/pages/auth/auth_page.dart';
import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/ui/pages/category/category_page.dart';
import 'package:ajhman/ui/pages/course/course_chapter/course_chapter_page.dart';
import 'package:ajhman/ui/pages/exam/exam_info.dart';
import 'package:ajhman/ui/pages/exam/exam_page.dart';
import 'package:ajhman/ui/pages/exam/exam_result_page.dart';
import 'package:ajhman/ui/pages/file_manager/file_manager_page.dart';
import 'package:ajhman/ui/pages/home/home_page.dart';
import 'package:ajhman/ui/pages/points_platform/points_platform_page.dart';
import 'package:ajhman/ui/pages/profile/profile_page.dart';
import 'package:ajhman/ui/pages/search/search_page.dart';
import 'package:ajhman/ui/pages/splash_page.dart';
import 'package:ajhman/ui/pages/summery/summery_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/args/course_args.dart';
import '../../ui/pages/course/course_main_page.dart';
import '../../ui/pages/smart_schedule/smart_schedule_page.dart';
import '../bloc/auth/auth_screen_bloc.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/comments/comments_bloc.dart';
import '../bloc/course/main/course_main_bloc.dart';
import '../bloc/for_you/for_you_bloc.dart';
import '../bloc/learning/leaning_bloc.dart';
import '../bloc/otp/otp_bloc.dart';
import '../bloc/pin/pin_bloc.dart';
import '../bloc/roadmap/roadmap_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/smart_schedule/planner_cubit.dart';
import '../bloc/smart_schedule/smart_schedule_bloc.dart';
import '../bloc/treasure/treasure_bloc.dart';
import '../cubit/summery/summery_cubit.dart';

class RouteGenerator {
  static Route<dynamic> destination(RouteSettings routeSettings) {
    switch (routeSettings.name.toString()) {
      case RoutePaths.splash:
        return _createRoute(const SplashPage());

      case RoutePaths.authStarted:
        return _createRoute(const AuthPageStarted());
      case RoutePaths.auth:
        return _createRoute(MultiBlocProvider(providers: [
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
        ], child: const AuthPage()));

      case RoutePaths.home:
        return _createRoute(MultiBlocProvider(providers: [
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
        ], child: const HomePage()));
      case RoutePaths.category:
        return _createRoute(
          BlocProvider<CategoryBloc>(
            create: (buildContext) {
              final bloc = CategoryBloc();
              return bloc;
            },
            child: CategoryPage(
              args: routeSettings.arguments as CategoryArgs,
            ),
          ),
        );
      case RoutePaths.search:
        return _createRoute(
          BlocProvider<SearchBloc>(
            create: (buildContext) {
              final bloc = SearchBloc();
              return bloc;
            },
            child: const SearchPage(),
          ),
        );

      case RoutePaths.profile:
        return _createRoute(
          const ProfilePage(),
        );
      case RoutePaths.smartSchedule:
        return _createRoute(MultiBlocProvider(providers: [
          BlocProvider<SmartScheduleBloc>(
            create: (buildContext) {
              final bloc = SmartScheduleBloc();
              bloc.add(SmartScheduleToCalender());
              return bloc;
            },
          ),
          BlocProvider(
            create: (context) => PlannerCubit(),
          ),
        ], child: const SmartSchedulePage()));
      case RoutePaths.fileManager:
        return _createRoute(const FileManagerPage());

      case RoutePaths.courseMain:
        return _createRoute(MultiBlocProvider(
          providers: [
            BlocProvider<CourseMainBloc>(
              create: (buildContext) {
                final bloc = CourseMainBloc();
                return bloc;
              },
            ),
            BlocProvider<RoadmapBloc>(
              create: (buildContext) {
                final bloc = RoadmapBloc();
                return bloc;
              },
            ),
          ],
          child: CourseMainPage(
            args: routeSettings.arguments as CourseMainArgs,
          ),
        ));
      case RoutePaths.course:
        return _createRoute(MultiBlocProvider(
          providers: [
            BlocProvider<CommentsBloc>(
              create: (buildContext) {
                final bloc = CommentsBloc();
                return bloc;
              },
            ),
          ],
          child: CourseChapterPage(args: routeSettings.arguments as CourseArgs),
        ));
      case RoutePaths.leaderboard:
        return _createRoute(PointsPlatformPage(
          response: routeSettings.arguments as LeaderboardModel,
        ));

      case RoutePaths.exam:
        return _createRoute(ExamPage(
          response: routeSettings.arguments as ExamArgs,
          // response: ExamResponseModel(),
        ));
      case RoutePaths.examInfo:
        return _createRoute(ExamInfo(
          courseId: routeSettings.arguments as int,
        ));
      case RoutePaths.examResult:
        return _createRoute(ExamResultPage(
            result: routeSettings.arguments as AnswerResultModel));
      case RoutePaths.summery:
        return _createRoute(
          BlocProvider(
            create: (context) => SummeryCubit(),
            child: SummeryPage(id: routeSettings.arguments as int),
          ),
        );

      default:
        return _createRoute(const SizedBox());
    }
  }

  static Route _createRoute(dynamic page) {
    return CupertinoPageRoute(builder: (context) {
      return page;
    });
  }
}
