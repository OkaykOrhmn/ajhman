import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/card/new_course_card.dart';
import 'package:ajhman/ui/widgets/divider/vertical_dashed_line.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/for_you/for_you_bloc.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/button/custom_primary_button.dart';
import '../../../widgets/loading/three_bounce_loading.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  @override
  void initState() {
    context.read<ForYouBloc>().add(GetAllForYou());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: backgroundColor100,
              borderRadius: DesignConfig.highBorderRadius,
            ),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CustomPrimaryButton(
                  fill: true,
                  color: secondaryColor,
                  onClick: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icon.boldNote
                          .svg(width: 24, height: 24, color: Colors.white),
                      const SizedBox(
                        width: 8,
                      ),
                      PrimaryText(
                          text: "برنامه یادگیری سازمان",
                          style: mThemeData.textTheme.dialogTitle,
                          color: Colors.white)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                PrimaryText(
                    text:
                        "با احترام، این برنامه آموزشی توسط سازمان برای شما در نظر گرفته شده است تا بهترین نتیجه را بدست آورید. این برنامه با هدف ارتقای دانش و مهارت‌های شما طراحی شده است.",
                    style: mThemeData.textTheme.title,
                    color: grayColor800)
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocBuilder<ForYouBloc, ForYouState>(
            builder: (context, state) {
              if (state is ForYouSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: VerticalListView(
                    item: (context, index) {
                      if (state.response[index].status == "not learned") {
                        state.response[index].canStart = true;
                        if (index != 0) {
                          if (state.response[index - 1].status ==
                              "not learned") {
                            state.response[index].canStart = false;
                          }
                        }
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 420,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: index == 0 ? 0 : 0,
                                  bottom: index == state.response.length - 1
                                      ? 200
                                      : 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    padding: EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                        color: state.response[index].status == "learned"
                                            ? primaryColor
                                            : backgroundColor100,
                                        border: state.response[index].status == "learning"
                                            ? Border.all(
                                                width: 1, color: primaryColor)
                                            : null,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: PrimaryText(
                                            text: "${index + 1}",
                                            style:
                                                mThemeData.textTheme.headerBold,
                                            color: state.response[index].status == "learning"
                                                ? Colors.white
                                                : state.response[index].status == "learned"
                                                    ? primaryColor
                                                    : grayColor600)),
                                  ),
                                  Expanded(
                                    child: VerticalDashedLine(
                                      active: state.response[index].status == "learned"
                                          ? primaryColor
                                          : null,
                                      dashed: state.response[index].status == "learned",
                                      dashSize: 8,
                                      width: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: NewCourseCard(
                              index: index,
                              response: state.response[index],
                            ),
                          )
                        ],
                      );
                    },
                    items: state.response,
                  ),
                );
              } else {
                return ThreeBounceLoading();
              }
            },
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
