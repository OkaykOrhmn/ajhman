import 'package:ajhman/core/cubit/answer/answer_cubit.dart';
import 'package:ajhman/core/cubit/answer/answer_cubit.dart';
import 'package:ajhman/data/args/exam_args.dart';
import 'package:ajhman/data/model/answer_request_model.dart';
import 'package:ajhman/data/model/exam_response_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

import '../../../core/cubit/timer/timer_cubit.dart';
import '../../../core/routes/route_paths.dart';
import '../../../core/utils/usefull_funcs.dart';
import '../../../data/model/answer_result_model.dart';
import '../../../data/repository/exam_repository.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/widget/design_config.dart';
import '../../widgets/dialogs/dialog_handler.dart';
import '../../widgets/loading/three_bounce_loading.dart';

class ExamPage extends StatefulWidget {
  final ExamArgs response;

  const ExamPage({super.key, required this.response});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<Exam> exams = [
    // Exam(
    //     text:
    //         "چرا در اکثر قرار های ملاقات کنترل هیجانات کار دشواری است و فرد وارد یک جنگ روانی می‌شود؟ ",
    //     id: 0,
    //     options: [
    //       "الف) لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است",
    //       "ب) لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است",
    //       "ج) لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است",
    //       "د) لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است",
    //     ]),
    // Exam(text: "چطوریییییییییییی ؟ ", id: 1, options: [
    //   "الف) لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است",
    //   "ب) لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است",
    //   "ج) لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است",
    //   "د) لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است",
    // ])
  ];

  bool timOut = false;

  @override
  void initState() {
    exams = widget.response.model.exam!;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(minutes: exams.length * 2),
    );
    _animationController.addListener(() async {
      context.read<TimerCubit>().setTimer(_animationController.value);
      if (_animationController.status == AnimationStatus.completed) {
        setState(() {
          timOut = true;
        });
        AnswerRequestModel result = AnswerRequestModel(
            comment: widget.response.comment,
            answers:
                context.read<AnswerCubit>().state.answerRequestModel.answers);
        try {
          AnswerResultModel response = await examRepository.postExam(4, result);
          navigatorKey.currentState!
              .pushReplacementNamed(RoutePaths.examResult, arguments: response);
        } on DioError catch (e) {}
      }
    });
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const ReversibleAppBar(
          title: "آزمون دوره",
          canBack: false,
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                children: [
                  PrimaryText(
                      text: "آزمون فنون مذاکره",
                      style: mThemeData.textTheme.dialogTitle,
                      color: primaryColor900),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<TimerCubit, double>(
                    builder: (context, state) {
                      Color color = successMain;
                      double value = 1 - state;
                      double time =
                          _animationController.duration!.inSeconds.toDouble() -
                              (state *
                                  _animationController.duration!.inSeconds
                                      .toDouble());
                      if (value > 0.65) {
                        color = successMain;
                      } else if (value > 0.35) {
                        color = warningMain;
                      } else {
                        color = errorMain;
                      }
                      return Stack(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Positioned.fill(
                              child: LinearProgressIndicator(
                                value: value,
                                borderRadius: BorderRadius.circular(40),
                                valueColor: AlwaysStoppedAnimation(color),
                                backgroundColor: color.withOpacity(0.2),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Assets.icon.outline.alarm.svg(
                                    width: 16, height: 16, color: grayColor800),
                                PrimaryText(
                                    text: getFormatDuration(time.round()),
                                    style: mThemeData.textTheme.rate,
                                    color: Colors.white)
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(child: BlocBuilder<AnswerCubit, AnswerModel>(
                    builder: (context, state) {
                      int? selectedIndex;
                      final exam = exams[state.index];

                      for (var element in state.answerRequestModel.answers!) {
                        if (element.questionId == exam.id) {
                          selectedIndex = element.answer! - 1;
                        }
                      }
                      final GroupButtonController _radioController =
                          GroupButtonController(selectedIndex: selectedIndex);

                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: DesignConfig.highBorderRadius,
                            color: backgroundColor100,
                            boxShadow: DesignConfig.lowShadow),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                PrimaryText(
                                    text:
                                        "سوال ${state.index + 1} از ${exams.length}",
                                    style: mThemeData.textTheme.rate,
                                    color: grayColor800)
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: backgroundColor100,
                                  borderRadius: DesignConfig.highBorderRadius,
                                ),
                                child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryText(
                                      text: exam.text.toString(),
                                      style: mThemeData.textTheme.title,
                                      color: grayColor900,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    GroupButton(
                                      controller: _radioController,
                                      isRadio: true,
                                      options: GroupButtonOptions(
                                          groupingType: GroupingType.column),
                                      buttons: exam.options!,
                                      buttonIndexedBuilder:
                                          (selected, _index, context) {
                                        return Container(
                                          padding: EdgeInsets.all(8),
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration: BoxDecoration(
                                              color: selected
                                                  ? primaryColor50
                                                  : Colors.white,
                                              borderRadius: DesignConfig
                                                  .highBorderRadius),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Radio<int>(
                                                groupValue: _radioController
                                                    .selectedIndex,
                                                activeColor: primaryColor,
                                                value: _index,
                                                onChanged: (val) {
                                                  _radioController
                                                      .selectIndex(_index);
                                                },
                                              ),
                                              Expanded(
                                                  child: PrimaryText(
                                                text:
                                                    "${getAlphIndex(_index)}${exam.options![_index]}",
                                                style: mThemeData
                                                    .textTheme.searchHint,
                                                color: grayColor800,
                                                textAlign: TextAlign.start,
                                              )),
                                            ],
                                          ),
                                        );
                                      },
                                      onSelected: (val, i, selected) {
                                        context
                                            .read<AnswerCubit>()
                                            .changeAnswer(Answers(
                                                questionId: exam.id,
                                                answer: i + 1));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: PrimaryButton(
                                    title: state.index == exams.length - 1
                                        ? "پایان آزمون"
                                        : "سوال بعدی",
                                    onClick: () async {
                                      if (state.index == exams.length - 1) {
                                        AnswerRequestModel result =
                                            AnswerRequestModel(
                                                comment:
                                                    widget.response.comment,
                                                answers: state
                                                    .answerRequestModel
                                                    .answers);
                                        DialogHandler.showFinishExamBottomSheet(
                                            result);
                                      } else {
                                        final index = state.index + 1;
                                        context
                                            .read<AnswerCubit>()
                                            .changeIndex(index);
                                      }
                                    },
                                  )),
                                  SizedBox(
                                    width: state.index != 0 ? 16 : 0,
                                  ),
                                  state.index != 0
                                      ? Expanded(
                                          child: OutlinedPrimaryButton(
                                          title: "سوال قبلی",
                                          onClick: state.index != 0
                                              ? () {
                                                  final index = state.index - 1;
                                                  context
                                                      .read<AnswerCubit>()
                                                      .changeIndex(index);
                                                }
                                              : null,
                                        ))
                                      : const SizedBox()
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )),
                ],
              ),
              timOut
                  ? IgnorePointer(
                      ignoring: timOut,
                      child: Container(
                        color: Colors.white.withOpacity(0.5),
                        child: ThreeBounceLoading(),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
