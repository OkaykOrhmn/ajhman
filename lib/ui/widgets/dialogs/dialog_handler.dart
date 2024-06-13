import 'package:ajhman/data/model/answer_request_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/loading_btn.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';
import 'package:loading_btn/loading_btn.dart';
import 'dart:io';
import '../../../core/routes/route_paths.dart';
import '../../../data/model/answer_result_model.dart';
import '../../../data/repository/exam_repository.dart';
import '../../../gen/assets.gen.dart';

class DialogHandler {
  static ThemeData themeData = Theme.of(mContext);

  static Future<void> showErrorDialog(
      String title, String btnTitle, Function()? onTap) async {
    await showDialog(
      barrierDismissible: false,
      context: mContext,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
            borderRadius: DesignConfig.highBorderRadius),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: errorBackground),
                    padding: EdgeInsets.all(6),
                    child: Assets.icon.bold.closeCircle.svg()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: PrimaryText(
                    text: title,
                    style: themeData.textTheme.dialogTitle,
                    color: Colors.black),
              ),
              Container(
                  width: MediaQuery.sizeOf(context).width / 2,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: PrimaryButton(
                    title: btnTitle,
                    onClick: onTap,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showRegCourseDialog(
      String title, String btnTitle) async {
    await showDialog(
      barrierDismissible: false,
      context: mContext,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
            borderRadius: DesignConfig.highBorderRadius),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: successBackground),
                    padding: EdgeInsets.all(6),
                    child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: successMain),
                            padding: EdgeInsets.all(6),
                        child: Icon(CupertinoIcons.checkmark_alt,color: Colors.white,size: 46,))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: PrimaryText(
                    text: title,
                    style: themeData.textTheme.dialogTitle,
                    color: Colors.black),
              ),
              Container(
                  width: MediaQuery.sizeOf(context).width / 2,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: PrimaryButton(
                    title: btnTitle,
                    onClick: ()=> pop(),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showExitBottomSheet() async {
    await showModalBottomSheet(
        context: mContext,
        useSafeArea: true,
        builder: (context) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 5,
                    width: MediaQuery.sizeOf(context).width / 4,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: DesignConfig.highBorderRadius,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  PrimaryText(
                      text: "قصد خارج شدن از برنامه را دارید؟",
                      style: themeData.textTheme.titleBold,
                      color: Colors.black),
                  Gif(
                    image: Assets.gif.exit.provider(),
                    autostart: Autostart.loop,
                    width: MediaQuery.sizeOf(context).width / 1.3,
                    height: MediaQuery.sizeOf(context).width / 1.3,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                          child: PrimaryButton(
                            title: "بله",
                            onClick: () {
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else if (Platform.isIOS) {
                                exit(0);
                              }
                            },
                          )),
                      Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: OutlinedPrimaryButton(
                            title: "خیر",
                            onClick: () {
                              pop();
                            },
                          ))
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  static Future<void> showFinishExamBottomSheet(
      AnswerRequestModel answers) async {
    await showModalBottomSheet(
        context: mContext,
        useSafeArea: true,
        builder: (context) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 5,
                    width: MediaQuery.sizeOf(context).width / 4,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: DesignConfig.highBorderRadius,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  PrimaryText(
                      text: "آیا از پایان دادن به آزمون مطمئن هستید؟",
                      style: themeData.textTheme.titleBold,
                      color: Colors.black),
                  Container(
                    width: MediaQuery.sizeOf(context).width ,
                    height: MediaQuery.sizeOf(context).width / 1.3,
                    padding: EdgeInsets.fromLTRB(46, 32, 46, 32),
                    child: Assets.image.finishExam.svg(),
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                          child: PrimaryLoadingButton(
                            title: "بله",
                            onTap: (Function startLoading, Function stopLoading,
                                ButtonState btnState) async {
                              if (btnState == ButtonState.idle) {
                                startLoading();
                                try {
                                  AnswerResultModel response =
                                      await examRepository.postExam(4, answers);
                                  pop();
                                  navigatorKey.currentState!
                                      .pushReplacementNamed(
                                          RoutePaths.examResult,
                                          arguments: response);
                                } on DioError catch (e) {}

                                stopLoading();
                              }
                            },
                            disable: false,
                          )),
                      Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: OutlinedPrimaryButton(
                            title: "خیر",
                            onClick: () {
                              pop();
                            },
                          ))
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }



  static void pop() {
    Navigator.of(mContext).pop();
  }
}
