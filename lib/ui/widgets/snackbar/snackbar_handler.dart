import 'package:ajhman/core/enum/dialogs_status.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SnackBarHandler {
  final BuildContext context;

  SnackBarHandler(this.context);

  show(String message, DialogStatus status, bool isTop) {
    Color background = Colors.white;
    Color border = Colors.white;
    switch (status) {
      case DialogStatus.success:
        background = successBackground;
        border = successMain;
        break;

      case DialogStatus.error:
        background = errorBackground;
        border = errorMain;
        break;

      case DialogStatus.info:
        background = infoBackground;
        border = infoMain;
        break;

      case DialogStatus.warning:
        background = warningBackground;
        border = warningMain;
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: PrimaryText(
          text: message, style: mThemeData.textTheme.title, color: background),
      backgroundColor: border,
      dismissDirection: DismissDirection.vertical,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: DesignConfig.lowBorderRadius,
      ),
      margin: EdgeInsets.only(
          bottom: isTop ? MediaQuery.of(context).size.height - 90 : 36,
          left: 16,
          right: 16),
    ));
  }

  errorFetch(DioExceptionType type) {
    String message = '';
    switch (type) {
      case DioException.connectionTimeout:
      case DioException.connectionError:
        message = 'اینترنت خود را چک کنید!!';
        break;
      default:
        message = "خطایی پیش آمده است لطفا لحضاتی دیگر تلاش کنید!!";
        break;
    }

    show(message, DialogStatus.error, true);
  }

  static void pop() {
    navigatorKey.currentState!.pop();
  }
}
