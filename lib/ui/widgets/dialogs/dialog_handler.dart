// ignore_for_file: deprecated_member_use_from_same_package, empty_catches, deprecated_member_use

import 'dart:ui';

import 'package:ajhman/core/cubit/image_picker/image_picker_cubit.dart';
import 'package:ajhman/data/model/answer_request_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/button/custom_outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/loading_btn.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:loading_btn/loading_btn.dart';
import 'dart:io';
import '../../../core/routes/route_paths.dart';
import '../../../core/utils/app_locale.dart';
import '../../../data/model/answer_result_model.dart';
import '../../../data/repository/exam_repository.dart';
import '../../../gen/assets.gen.dart';

class DialogHandler {
  final BuildContext context;

  DialogHandler(this.context);

  /* Future<void> showErrorDialog(
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
  */

  Future<void> showWelcomeDialog() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
            borderRadius: DesignConfig.highBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Center(child: Assets.icon.main.sIcon.svg()),
            content: Text(
              ChangeLocale(context).appLocal!.welcomeSmartSchedule,
              style: AppTextStyles.descWelcomeDialogSmartSchedule,
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: OutlinedPrimaryButton(
                  title: ChangeLocale(context).appLocal!.confirm,
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showImageDialog(String src) async {
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Stack(
                children: [
                  InteractiveViewer(
                    panEnabled: true, // Set it to false to prevent panning.
                    minScale: 0.5,
                    maxScale: 4,

                    child: Center(
                      child: Stack(
                        children: [
                          PrimaryImageNetwork(
                            src: src,
                            aspectRatio: 16 / 9,
                            radius: BorderRadius.zero,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 24,
                      right: 24,
                      child: InkWell(
                          onTap: () => pop(),
                          child: Assets.icon.bold.closeCircle.svg(
                              color: Theme.of(context).black(),
                              width: 24,
                              height: 24)))
                ],
              )),
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
        backgroundColor: Theme.of(context).background(),
        builder: (context) {
          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5,
                    width: MediaQuery.sizeOf(context).width / 4,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).black(),
                      borderRadius: DesignConfig.highBorderRadius,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  PrimaryText(
                      text: "قصد خارج شدن از برنامه را دارید؟",
                      style: themeData.textTheme.titleBold,
                      color: Theme.of(context).black()),
                  Gif(
                    image: Assets.gif.exit.provider(),
                    autostart: Autostart.loop,
                    width: MediaQuery.sizeOf(context).width / 1.5,
                    height: MediaQuery.sizeOf(context).width / 1.5,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 18, 16, 8),
                        child: PrimaryButton(
                          title: "بله",
                          onClick: () {
                            if (Platform.isAndroid) {
                              SystemNavigator.pop();
                            } else if (Platform.isIOS) {
                              exit(0);
                            }
                          },
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 8, 8),
                        child: OutlinedPrimaryButton(
                          title: "خیر",
                          onClick: () {
                            pop();
                          },
                        ),
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
        backgroundColor: Theme.of(context).background(),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: MediaQuery.sizeOf(context).width / 4,
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).black(),
                  borderRadius: DesignConfig.highBorderRadius,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        context.read<ImagePickerCubit>().getImageFromGallery();
                        pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: DesignConfig.mediumBorderRadius,
                          color: Theme.of(context).cardBackground(),
                        ),
                        width: 100,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.icon.outline.folder2.svg(
                                width: 32,
                                height: 32,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              height: 8,
                            ),
                            PrimaryText(
                                text: "حافظه داخلی",
                                style: themeData.textTheme.title,
                                color: Theme.of(context).progressText())
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<ImagePickerCubit>().getImageFromCamera();
                        pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: DesignConfig.mediumBorderRadius,
                          color: Theme.of(context).cardBackground(),
                        ),
                        width: 100,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.icon.outline.camera.svg(
                                width: 32,
                                height: 32,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              height: 8,
                            ),
                            PrimaryText(
                                text: "دوربین",
                                style: themeData.textTheme.title,
                                color: Theme.of(context).progressText())
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 18, 16, 8),
                    child: PrimaryButton(
                      title: "بازگشت",
                      onClick: () {
                        pop();
                      },
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 8, 8),
                    child: CustomOutlinedPrimaryButton(
                      color: errorMain,
                      child: PrimaryText(
                          text: "حذف عکس",
                          style: AppTextStyles.outlinedPrimaryButtonText,
                          color: errorMain),
                      onClick: () {
                        context.read<ImagePickerCubit>().deleteProfileImage();
                        pop();
                      },
                    ),
                  ))
                ],
              ),
            ],
          );
        });
  }

  Future<void> showFinishExamBottomSheet(
      AnswerRequestModel answers, int courseId) async {
    ThemeData themeData = Theme.of(context);
    await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        backgroundColor: Theme.of(context).background(),
        builder: (context) {
          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 5,
                    width: MediaQuery.sizeOf(context).width / 4,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).black(),
                      borderRadius: DesignConfig.highBorderRadius,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryText(
                      text: "آیا از پایان دادن به آزمون مطمئن هستید؟",
                      style: themeData.textTheme.titleBold,
                      color: Theme.of(context).black()),
                  const SizedBox(
                    height: 24,
                  ),
                  Assets.image.finishExam.svg(
                    width: MediaQuery.sizeOf(context).width / 2,
                    height: MediaQuery.sizeOf(context).width / 2,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 18, 16, 8),
                        child: PrimaryLoadingButton(
                          title: "بله",
                          onTap: (Function startLoading, Function stopLoading,
                              ButtonState btnState) async {
                            if (btnState == ButtonState.idle) {
                              startLoading();
                              try {
                                AnswerResultModel response =
                                    await examRepository.postExam(
                                        courseId, answers);
                                response.courseId = courseId;
                                pop();
                                navigatorKey.currentState!.pushReplacementNamed(
                                    RoutePaths.examResult,
                                    arguments: response);
                              } on DioError {}

                              stopLoading();
                            }
                          },
                          disable: false,
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 8, 8),
                        child: OutlinedPrimaryButton(
                          title: "خیر",
                          onClick: () {
                            pop();
                          },
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }
}
