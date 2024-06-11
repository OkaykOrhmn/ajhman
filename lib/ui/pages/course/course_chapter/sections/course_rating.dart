import 'package:ajhman/core/bloc/questions/questions_bloc.dart';
import 'package:ajhman/data/model/feedbacks_questions_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

import '../../../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../../../data/model/questions_model.dart';

class CourseRating extends StatefulWidget {
  const CourseRating({super.key});

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

  late QuestionsModel questionsModel;

  @override
  Widget build(BuildContext context) {
    final data = context.read<ChapterBloc>().state.data!;

    return BlocProvider<QuestionsBloc>(
      create: (buildContext) {
        final bloc = QuestionsBloc();
        bloc.add(GetAllQuestions(id: data.id!));
        return bloc;
      },
      child: BlocConsumer<QuestionsBloc, QuestionsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is QuestionsSuccess) {
            questionsModel = state.questionsModel;
            print(questionsModel.toJson());
            return questionsModel.questions!.isEmpty?SizedBox():Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: backgroundColor100,
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
                        color: CupertinoColors.white,
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
                                style: mThemeData.textTheme.headerLargeBold,
                                color: grayColor700),
                            SizedBox(
                              width: 16,
                            ),
                            PrimaryText(
                                text: "(از ۳۴۱ رای)",
                                style: mThemeData.textTheme.title,
                                color: grayColor700)
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        PrimaryText(
                            text:
                                "نظرات شما باعث رشد و پیشرفت آژمان می‌شود ممنونم که در این راه ما را همراهی می‌کنید",
                            style: mThemeData.textTheme.rate,
                            color: grayColor700)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  VerticalListView(
                      items: state.questionsModel.questions,
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
                              color: Colors.white,
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
                                      color: primaryColor,
                                    ),
                                    width: 2,
                                    height: 12,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  PrimaryText(
                                      text: q.question!.text.toString(),
                                      style: mThemeData.textTheme.title,
                                      color: grayColor900)
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
                                      Text(_radioButtons[_index]),
                                      Radio<int>(
                                        groupValue:
                                            _radioController.selectedIndex,
                                        activeColor: primaryColor,
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
                  OutlinedPrimaryButton(
                    title: "ارسال",
                    fill: true,
                    onClick: () async {
                      List<Feedbacks> feeds = [];
                      for (var element in questionsModel.questions!) {
                        if (element.score != null) {
                          feeds.add(Feedbacks(
                              questionId: element.id, score: element.score));
                        }
                      }
                      print(FeedbacksQuestionsModel(feedbacks: feeds).toJson());
                      context.read<QuestionsBloc>().add(PutQuestions(
                          id: data.id!,
                          feedbacksQuestionsModel:
                              FeedbacksQuestionsModel(feedbacks: feeds),
                          questionsModel: questionsModel));
                    },
                  )
                ],
              ),
            );
          } else if (State is QuestionsFail) {
            return SizedBox();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
