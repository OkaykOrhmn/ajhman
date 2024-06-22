import 'package:ajhman/core/bloc/questions/questions_bloc.dart';
import 'package:ajhman/core/enum/dialogs_status.dart';
import 'package:ajhman/data/model/feedbacks_questions_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/outline_primary_loading_button.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/snackbar/snackbar_handler.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';
import '../../../../../data/model/questions_model.dart';

class CourseRating extends StatefulWidget {
  final int id;
  const CourseRating({super.key, required this.id});

  @override
  State<CourseRating> createState() => _CourseRatingState();
}

class Rates {
  String title;
  int rate;

  Rates(this.title, this.rate);
}

class _CourseRatingState extends State<CourseRating> {
  final List<Rates> items = [
    Rates("جامع و کامل بودن دوره", 0),
    Rates("کیفیت ارائه مطالب", 0),
    Rates("انتقال درست مفاهیم", 0),
    Rates("میزان تسلط استاد به مفاهیم", 0),
    Rates("کاربردی بودن مفاهیم دوره", 0),
  ];
  final _radioButtons = [
    'ضعیف',
    'متوسط',
    'قوی',
  ];

  QuestionsModel questionsModel = QuestionsModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
      if (state is QuestionsSuccess) {
        questionsModel = state.questionsModel;
      } else if (state is QuestionsPutFail) {
        questionsModel = state.questionsModel;
      }
      return questionsModel.questions != null &&
              questionsModel.questions!.isNotEmpty
          ? Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardBackground(),
                  borderRadius: DesignConfig.highBorderRadius),
              child: Column(
                children: [
                  TitleDivider(
                    title: "نظرات",
                    hasPadding: false,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).white(),
                        borderRadius: DesignConfig.highBorderRadius),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: goldColor,
                              size: 32,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            PrimaryText(
                                text: "4.2",
                                style: Theme.of(context).textTheme.headerLargeBold,
                                color: Theme.of(context).cardText()),
                            SizedBox(
                              width: 16,
                            ),
                            PrimaryText(
                                text: "(از ۳۴۱ رای)",
                                style: Theme.of(context).textTheme.title,
                                color: Theme.of(context).cardText())
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        PrimaryText(
                            text:
                                "نظرات شما باعث رشد و پیشرفت آژمان می‌شود ممنونم که در این راه ما را همراهی می‌کنید",
                            style: Theme.of(context).textTheme.rate,
                            color: Theme.of(context).cardText())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  VerticalListView(
                      items: questionsModel.questions,
                      item: (context, index) {
                        final q = questionsModel.questions![index];
                        late GroupButtonController _radioController =
                            GroupButtonController(
                                selectedIndex:
                                    q.score == null ? null : q.score! - 1);

                        return Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              color: Theme.of(context).onWhite(),
                              boxShadow: DesignConfig.lowShadow,
                              borderRadius: DesignConfig.highBorderRadius),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          DesignConfig.mediumBorderRadius,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    width: 2,
                                    height: 12,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  PrimaryText(
                                      text: q.question!.text.toString(),
                                      style: Theme.of(context).textTheme.title,
                                      color: Theme.of(context).progressText())
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              GroupButton(
                                controller: _radioController,
                                isRadio: true,
                                options: GroupButtonOptions(
                                    groupingType: GroupingType.row),
                                buttons: _radioButtons,
                                buttonIndexedBuilder:
                                    (selected, _index, context) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PrimaryText(text: _radioButtons[_index],style: Theme.of(context).textTheme.title,color: Theme.of(context).progressText(),),
                                      Radio<int>(
                                        groupValue:
                                            _radioController.selectedIndex,
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: _index,
                                        onChanged: (val) {
                                          _radioController.selectIndex(_index);
                                          questionsModel.questions![index]
                                              .score = val! + 1;
                                        },
                                      )
                                    ],
                                  );
                                },
                                onSelected: (val, i, selected) {
                                  // questionsModel.questions![index].score = i;
                                },
                              )
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 8,
                  ),
                  OutlinePrimaryLoadingButton(
                    title: "ارسال",
                    onTap: (Function startLoading, Function stopLoading,
                        ButtonState btnState) async {
                      if (btnState == ButtonState.idle) {
                        startLoading();
                        List<Feedbacks> feeds = [];
                        for (var element in questionsModel.questions!) {
                          if (element.score != null) {
                            feeds.add(Feedbacks(
                                questionId: element.id, score: element.score));
                          }
                        }
                        context.read<QuestionsBloc>().add(PutQuestions(
                            id: widget.id,
                            feedbacksQuestionsModel:
                                FeedbacksQuestionsModel(feedbacks: feeds),
                            questionsModel: questionsModel));
                        context
                            .read<QuestionsBloc>()
                            .stream
                            .firstWhere((element) =>
                                state is QuestionsSuccess ||
                                state is QuestionsPutFail)
                            .then((value) {
                          if (value is QuestionsSuccess) {
                            SnackBarHandler(context).show(
                                "نظر با موفقیت ثبت شد 😃",
                                DialogStatus.success,
                                true);
                          }
                          if (value is QuestionsPutFail) {
                            SnackBarHandler(context).show(
                                "خطا در ثیت نظر!", DialogStatus.error, true);
                          }
                        });
                        stopLoading();
                      }
                    },
                    disable: false,
                  )
                ],
              ),
            )
          : const SizedBox();
    });
  }
}
