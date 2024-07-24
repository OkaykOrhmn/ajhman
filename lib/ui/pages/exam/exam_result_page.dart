// ignore_for_file: deprecated_member_use, empty_catches

import 'package:ajhman/data/model/answer_result_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/loading_btn.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/progress/circle_progress.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../core/cubit/leaderboard/leaderboard_cubit.dart';
import '../../../core/routes/route_paths.dart';
import '../../../data/model/leaderboard_model.dart';
import '../../../data/repository/course_repository.dart';
import '../../../gen/assets.gen.dart';

class ExamResultPage extends StatefulWidget {
  final AnswerResultModel result;

  const ExamResultPage({super.key, required this.result});

  @override
  State<ExamResultPage> createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  late AnswerResultModel result;
  double correctValue = 0;
  double inCorrectValue = 0;
  double noAnswerValue = 0;
  bool success = false;

  @override
  void initState() {
    result = widget.result;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (result.correct != null && result.correct != 0) {
      correctValue = result.correct! / result.total!;
      success = correctValue >= 0.6;
    }

    if (result.incorrect != null && result.incorrect != 0) {
      inCorrectValue = result.incorrect! / result.total!;
    }

    if (result.noAnswer != null && result.noAnswer != 0) {
      noAnswerValue = result.noAnswer! / result.total!;
    }

    context.read<LeaderboardCubit>().setExamScore((correctValue * 100).round());

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const ReversibleAppBar(
          title: "آزمون دوره",
          canBack: false,
        ),
        backgroundColor: Theme.of(context).background(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              _mainPicture(success),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    boxShadow: DesignConfig.lowShadow,
                    borderRadius: DesignConfig.highBorderRadius,
                    color: Theme.of(context).white()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryText(
                      text: "آمار پاسخگویی شما",
                      style: mThemeData.textTheme.rate,
                      color: Theme.of(context).headText(),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleProgress(
                          text: '${result.correct!} سوال\nصحیح',
                          value: correctValue,
                          strokeWidth: 6,
                          color: successMain,
                          width: MediaQuery.sizeOf(context).width / 4.4,
                          height: MediaQuery.sizeOf(context).width / 4.4,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        CircleProgress(
                          text: '${result.noAnswer!} سوال\nبدون پاسخ',
                          value: noAnswerValue,
                          strokeWidth: 6,
                          width: MediaQuery.sizeOf(context).width / 4.4,
                          height: MediaQuery.sizeOf(context).width / 4.4,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        CircleProgress(
                          text: '${result.incorrect} سوال\nغلط',
                          value: inCorrectValue,
                          strokeWidth: 6,
                          color: errorMain,
                          width: MediaQuery.sizeOf(context).width / 4.4,
                          height: MediaQuery.sizeOf(context).width / 4.4,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              _mainResultTitle(success ? 0 : null),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Column(
                  children: [
                    PrimaryLoadingButton(
                      title: "رفتن به لیدر بورد",
                      onTap: (Function startLoading, Function stopLoading,
                          ButtonState btnState) async {
                        if (btnState == ButtonState.idle) {
                          startLoading();
                          try {
                            LeaderboardModel response = await courseRepository
                                .getLeaderboard(widget.result.courseId!);
                            navigatorKey.currentState!.pushReplacementNamed(
                                RoutePaths.leaderboard,
                                arguments: response);
                          } on DioError {}

                          stopLoading();
                        }
                      },
                      disable: false,
                    ),
                    OutlinedPrimaryButton(
                      title: "بازگشت به خانه",
                      fill: true,
                      onClick: () {
                        navigatorKey.currentState!.pop();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _mainResultTitle(int? score) {
    final title = score != null
        ? 'شما مجاز به کسب مدرک آزمون شدید! '
        : 'شما مجاز به دریافت مدرک آزمون نشدید !';
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: score != null ? successBackground : errorBackground,
                borderRadius: DesignConfig.highBorderRadius),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16).copyWith(top: 0),
            child: PrimaryText(
              text: title,
              style: mThemeData.textTheme.title,
              color: score != null ? successMain : errorMain,
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }

  Widget _mainPicture(bool success) {
    final icon = success ? Assets.image.successExam : Assets.image.failExam;
    final title =
        success ? "تبریک می‌گم! شما قبول شدید" : "متاسفم! شما رد شدید";
    return Center(
        child: Column(
      children: [
        icon.svg(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).width / 2),
        const SizedBox(
          height: 24,
        ),
        PrimaryText(
            text: title,
            style: mThemeData.textTheme.headerLargeBold,
            color: success ? successMain : errorMain)
      ],
    ));
  }
}
