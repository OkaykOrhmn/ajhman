import 'package:ajhman/data/model/roadmap_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/road.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../gen/assets.gen.dart';

class RoadMapPage extends StatefulWidget {
  final RoadmapModel response;

  const RoadMapPage({super.key, required this.response});

  @override
  State<RoadMapPage> createState() => _RoadMapPageState();
}

class _RoadMapPageState extends State<RoadMapPage> {
  List<String> items = [];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: backgroundColor200,
                borderRadius: DesignConfig.highBorderRadius),
            child: Column(
              children: [
                PrimaryText(
                    text: "دوره سازمان‌‌های یادگیرنده",
                    style: mThemeData.textTheme.titleBold,
                    color: secondaryColor),
                SizedBox(
                  height: 8,
                ),
                PrimaryText(
                    text:
                        'در رودمپ زیر شما می‌توانید مسیر یادگیری خودتان را مشاهده کنید',
                    style: mThemeData.textTheme.rate,
                    color: grayColor900),
              ],
            ),
          ),
          SizedBox(height: 44,),
          VerticalListView(
              items: [1, 2, 3, 4,5,6,7,8,9,10],
              item: (context, index) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: (index + 1) % 2 == 0
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 24),
                                    width: 130,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            DesignConfig.mediumBorderRadius,
                                        color: CupertinoColors.white,
                                        border:
                                            Border.all(color: Color(0xffFF5F8F)),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PrimaryText(
                                            text: "فصل اول",
                                            style: mThemeData.textTheme.titleBold,
                                            color: Color(0xffFF5F8F),
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Assets.icon.outlineMedal.svg(
                                                  color: goldColor,
                                                  width: 16,
                                                  height: 16),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              PrimaryText(
                                                  text: "۸۵ از ۱۰۰",
                                                  style: mThemeData
                                                      .textTheme.searchHint,
                                                  color: grayColor800)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: LinearProgress(
                                              value: 0.8,
                                              minHeight: 8,
                                              backgroundColor: Color(0xffFFE2F3),
                                              valueColor: Color(0xffFF5F8F),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Assets.shape.shape.svg())
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Road(index: index+1)
                  ],
                );
              }),
        ],
      ),
    );
  }
}
