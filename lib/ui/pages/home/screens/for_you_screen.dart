import 'package:ajhman/core/enum/card_type.dart';
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

import '../../../../gen/assets.gen.dart';
import '../../../widgets/button/custom_primary_button.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor100,
              borderRadius: DesignConfig.highBorderRadius,
            ),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CustomPrimaryButton(
                  fill: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icon.boldNote
                          .svg(width: 24, height: 24, color: Colors.white),
                      SizedBox(
                        width: 8,
                      ),
                      PrimaryText(
                          text: "برنامه یادگیری سازمان",
                          style: mThemeData.textTheme.dialogTitle,
                          color: Colors.white)
                    ],
                  ),
                  color: secondaryColor,
                  onClick: () {},
                ),
                SizedBox(
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
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: VerticalListView(
              item: (context,index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 500,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: index == 0 ? 4 : 0,
                            bottom: index == 3 ? 200 : 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              padding: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                  color: index == 0
                                      ? primaryColor
                                      : backgroundColor100,
                                  border: index == 1
                                      ? Border.all(
                                          width: 1, color: primaryColor)
                                      : null,
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: PrimaryText(
                                      text: "${index + 1}",
                                      style: mThemeData.textTheme.headerBold,
                                      color: index == 0
                                          ? Colors.white
                                          : index == 1
                                              ? primaryColor
                                              : grayColor600)),
                            ),
                            Expanded(
                              child: VerticalDashedLine(
                                active: index == 0 ? primaryColor : null,
                                dashed: index != 0,
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
                      child: SizedBox(
                          height: 480,
                          child: NewCourseCard(
                              index: index, type: CardType.onLearning)),
                    )
                  ],
                );
              },
              items: [1, 2, 3, 4],
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
