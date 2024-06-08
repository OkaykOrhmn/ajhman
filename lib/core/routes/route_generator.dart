import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/ui/audio_player.dart';
import 'package:ajhman/ui/pages/auth/auth_page.dart';
import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/ui/pages/course/course_chapter/course_chapter_page.dart';
import 'package:ajhman/ui/pages/home/home_page.dart';
import 'package:ajhman/ui/pages/splash_page.dart';
import 'package:flutter/cupertino.dart';

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
        return _createRoute(const CourseMainPage());
      case RoutePaths.course:
        return _createRoute(const CourseChapterPage());
      case RoutePaths.audio:
        return _createRoute(const AudioPlayerScreen());
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
