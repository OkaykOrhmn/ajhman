import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/data/args/category_args.dart';
import 'package:ajhman/data/args/course_main_args.dart';
import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/ui/pages/auth/auth_page.dart';
import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/ui/pages/category/category_page.dart';
import 'package:ajhman/ui/pages/course/course_chapter/course_chapter_page.dart';
import 'package:ajhman/ui/pages/home/home_page.dart';
import 'package:ajhman/ui/pages/splash_page.dart';
import 'package:flutter/cupertino.dart';

import '../../data/args/course_args.dart';
import '../../ui/pages/course/course_info.dart';
import '../../ui/pages/course/course_main_page.dart';
import '../../ui/pages/smart_schedule/smart_schedule_page.dart';

class RouteGenerator {
  static Route<dynamic> destination(RouteSettings routeSettings) {
    switch (routeSettings.name.toString()) {
      case RoutePaths.splash:
        return _createRoute(const SplashPage());
      case RoutePaths.home:
        return _createRoute(const HomePage());

      case RoutePaths.authStarted:
        return _createRoute(const AuthPageStarted());

      case RoutePaths.auth:
        return _createRoute(const AuthPage());

      case RoutePaths.smartSchedule:
        return _createRoute(const SmartSchedulePage());
      case RoutePaths.courseMain:
        return _createRoute( CourseMainPage(  args:CourseMainArgs(courseId: 4),));
      case RoutePaths.courseInfo:
        return _createRoute( CourseInfo(  response:routeSettings.arguments as CourseMainResponseModel,));
      case RoutePaths.course:
        return _createRoute( CourseChapterPage(args: routeSettings.arguments as CourseArgs));
      case RoutePaths.category:
        return _createRoute(CategoryPage(
          args: routeSettings.arguments as CategoryArgs,
        ));
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
