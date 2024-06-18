import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/data/args/category_args.dart';
import 'package:ajhman/data/args/course_main_args.dart';
import 'package:ajhman/data/args/exam_args.dart';
import 'package:ajhman/data/model/answer_result_model.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/data/model/exam_response_model.dart';
import 'package:ajhman/data/model/leaderboard_model.dart';
import 'package:ajhman/ui/pages/auth/auth_page.dart';
import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/ui/pages/category/category_page.dart';
import 'package:ajhman/ui/pages/course/course_chapter/course_chapter_page.dart';
import 'package:ajhman/ui/pages/exam/exam_info.dart';
import 'package:ajhman/ui/pages/exam/exam_page.dart';
import 'package:ajhman/ui/pages/exam/exam_result_page.dart';
import 'package:ajhman/ui/pages/home/home_page.dart';
import 'package:ajhman/ui/pages/points_platform/points_platform_page.dart';
import 'package:ajhman/ui/pages/profile/profile_page.dart';
import 'package:ajhman/ui/pages/search/search_page.dart';
import 'package:ajhman/ui/pages/splash_page.dart';
import 'package:ajhman/ui/pages/summery/summery_page.dart';
import 'package:flutter/cupertino.dart';

import '../../data/args/course_args.dart';
import '../../data/model/answer_request_model.dart';
import '../../ui/pages/course/course_info_page.dart';
import '../../ui/pages/course/course_main_page.dart';
import '../../ui/pages/smart_schedule/smart_schedule_page.dart';

class RouteGenerator {
  static Route<dynamic> destination(RouteSettings routeSettings) {
    switch (routeSettings.name.toString()) {
      case RoutePaths.splash:
        return _createRoute(const SplashPage());
      case RoutePaths.profile:
        return _createRoute(const ProfilePage());
      case RoutePaths.home:
        return _createRoute(const HomePage());

      case RoutePaths.authStarted:
        return _createRoute(const AuthPageStarted());

      case RoutePaths.auth:
        return _createRoute(const AuthPage());

      case RoutePaths.smartSchedule:
        return _createRoute(const SmartSchedulePage());
      case RoutePaths.courseMain:
        return _createRoute( CourseMainPage(  args:routeSettings.arguments as CourseMainArgs,));
      case RoutePaths.course:
        return _createRoute( CourseChapterPage(args: routeSettings.arguments as CourseArgs));
      case RoutePaths.category:
        return _createRoute(CategoryPage(
          args: routeSettings.arguments as CategoryArgs,
        ));
      case RoutePaths.exam:
        return _createRoute(ExamPage(
          response: routeSettings.arguments as ExamArgs,
          // response: ExamResponseModel(),
        ));
      case RoutePaths.examInfo:
        return _createRoute( ExamInfo(courseId: routeSettings.arguments as int,));
      case RoutePaths.examResult:
        return _createRoute( ExamResultPage(
            result: routeSettings.arguments as AnswerResultModel
        ));
      case RoutePaths.search:
        return _createRoute( const SearchPage());
        case RoutePaths.summery:
        return _createRoute( SummeryPage(id: routeSettings.arguments as int));
      case RoutePaths.leaderboard:
        return _createRoute(  PointsPlatformPage(response: routeSettings.arguments as LeaderboardModel,));
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
