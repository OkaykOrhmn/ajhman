import 'dart:async';
import 'dart:ui';

import 'package:ajhman/core/enum/dialogs_status.dart';
import 'package:ajhman/data/model/answer_request_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/custom_outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/loading_btn.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';
import 'package:loading_btn/loading_btn.dart';
import 'dart:io';
import '../../../core/routes/route_paths.dart';
import '../../../core/utils/app_locale.dart';
import '../../../data/model/answer_result_model.dart';
import '../../../data/repository/exam_repository.dart';
import '../../../gen/assets.gen.dart';

class SnackBarHandler {
  final BuildContext context;

  SnackBarHandler(this.context);

  show(String message, DialogStatus status, bool isTop) {
    Color background = Colors.white;
    Color border = Colors.white;
    Color text = Colors.black;
    switch (status) {
      case DialogStatus.success:
        background = successBackground;
        border = successMain;
        text = successFont;
        break;

      case DialogStatus.error:
        background = errorBackground;
        border = errorMain;
        text = errorFont;
        break;

      case DialogStatus.info:
        background = infoBackground;
        border = infoMain;
        text = infoFont;
        break;

      case DialogStatus.warning:
        background = warningBackground;
        border = warningMain;
        text = warningFont;
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: PrimaryText(
          text: message, style: mThemeData.textTheme.title, color: background),
      backgroundColor: border,
      dismissDirection: DismissDirection.vertical,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
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
