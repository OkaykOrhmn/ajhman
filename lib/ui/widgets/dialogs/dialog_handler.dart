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
import '../../../data/model/answer_result_model.dart';
import '../../../data/repository/exam_repository.dart';
import '../../../gen/assets.gen.dart';

class DialogHandler {
  final BuildContext context;

  DialogHandler(this.context);

  Future<void> showErrorDialog(
      String title, String btnTitle, Function()? onTap) async {
    ThemeData themeData = Theme.of(context);
    await showDialog(
      barrierDismissible: false,
      context: context,
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
                    padding: const EdgeInsets.all(6),
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

  Future<void> showRegCourseDialog(String title, String btnTitle) async {
    ThemeData themeData = Theme.of(context);
    await showDialog(
      barrierDismissible: false,
      context: context,
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
                    padding: const EdgeInsets.all(6),
                    child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: successMain),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Colors.white,
                          size: 46,
                        ))),
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
                    onClick: () => pop(),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showExitBottomSheet() async {
    ThemeData themeData = Theme.of(context);
    await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        builder: (context) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 5,
                    width: MediaQuery.sizeOf(context).width / 4,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: DesignConfig.highBorderRadius,
                    ),
                  ),
                  const SizedBox(
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
                          padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
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
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
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

  Future<void> showChoiceProfileSheet() async {
    ThemeData themeData = Theme.of(context);
    await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: MediaQuery.sizeOf(context).width / 4,
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: DesignConfig.highBorderRadius,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: DesignConfig.mediumBorderRadius,
                        color: backgroundColor100,
                      ),
                      width: 100,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icon.outline.profileCircle
                              .svg(width: 32, height: 32, color: Theme.of(context).primaryColor),
                          const SizedBox(
                            height: 8,
                          ),
                          PrimaryText(
                              text: "آواتار",
                              style: mThemeData.textTheme.title,
                              color: grayColor900)
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: DesignConfig.mediumBorderRadius,
                        color: backgroundColor100,
                      ),
                      width: 100,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icon.outline.folder2
                              .svg(width: 32, height: 32, color: Theme.of(context).primaryColor),
                          const SizedBox(
                            height: 8,
                          ),
                          PrimaryText(
                              text: "حافظه داخلی",
                              style: mThemeData.textTheme.title,
                              color: grayColor900)
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: DesignConfig.mediumBorderRadius,
                        color: backgroundColor100,
                      ),
                      width: 100,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icon.outline.camera
                              .svg(width: 32, height: 32, color: Theme.of(context).primaryColor),
                          const SizedBox(
                            height: 8,
                          ),
                          PrimaryText(
                              text: "دوربین",
                              style: mThemeData.textTheme.title,
                              color: grayColor900)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                      width: MediaQuery.sizeOf(context).width / 2,
                      padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                      child: PrimaryButton(
                        title: "بازگشت",
                        onClick: () {
                          pop();
                        },
                      )),
                  Container(
                      width: MediaQuery.sizeOf(context).width / 2,
                      padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                      child: CustomOutlinedPrimaryButton(
                        color: errorMain,
                        child: PrimaryText(
                            text: "حذف عکس",
                            style: AppTextStyles.outlinedPrimaryButtonText,
                            color: errorMain),
                        onClick: () {
                          pop();
                        },
                      ))
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          );
        });
  }

  Future<void> showFinishExamBottomSheet(AnswerRequestModel answers) async {
    ThemeData themeData = Theme.of(context);
    await showModalBottomSheet(
        context: context,
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
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: DesignConfig.highBorderRadius,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  PrimaryText(
                      text: "آیا از پایان دادن به آزمون مطمئن هستید؟",
                      style: themeData.textTheme.titleBold,
                      color: Colors.black),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).width / 1.3,
                    padding: const EdgeInsets.fromLTRB(46, 32, 46, 32),
                    child: Assets.image.finishExam.svg(),
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
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
    navigatorKey.currentState!.pop();
  }
}
