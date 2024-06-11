import 'package:ajhman/core/enum/state_status.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/model/roadmap_model.dart';
import 'package:ajhman/data/model/roadmap_view.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/road.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../core/bloc/course/main/course_main_bloc.dart';
import '../../../core/routes/route_paths.dart';
import '../../../data/model/course_main_response_model.dart';
import '../../../gen/assets.gen.dart';

class RoadMapPage extends StatefulWidget {
  final int courseId;
  final RoadmapModel response;

  const RoadMapPage(
      {super.key, required this.response, required this.courseId});

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
                    text: widget.response.name.toString(),
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
          SizedBox(
            height: 24,
          ),
          Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50, top: 12),
                    child: Container(
                      width: 30,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: DesignConfig.aVeryHighBorderRadius,
                              topLeft: DesignConfig.aVeryHighBorderRadius,
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero),
                          gradient: LinearGradient(colors: [
                            Color(0xff4A4A4A),
                            Color(0xff575757),
                          ])),
                      // child: VerticalDashedLine(width: 2,active: Colors.white, dashed: true),
                    ),
                  ),
                  VerticalListView(
                      items: [1, 2, 3],
                      item: (context, index) {
                        return Road(
                          index: index + 1,
                          length: 3 + 1,
                        );
                      }),
                ],
              ),
              VerticalListView(
                  items: [1, 2, 3],
                  item: (context, index) {
                    RoadmapView view = getRoadMapContainer(true, null);
                    return Column(
                      crossAxisAlignment: (index + 1) % 2 == 0
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 36),
                                width: 130,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        DesignConfig.mediumBorderRadius,
                                    color: CupertinoColors.white,
                                    border: Border.all(color: view.color),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(
                                        text: "فصل اول",
                                        style: mThemeData.textTheme.titleBold,
                                        color: view.color,
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
                                          backgroundColor:
                                              view.color.withOpacity(0.5),
                                          valueColor: view.color,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0, left: 0, child: view.shape.svg())
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(right: 64.0),
                child: Assets.image.flag.svg(),
              ))
            ],
          ),
          Stack(
            children: [
              Road(
                index: 4 % 2 == 0 ? 2 : 1,
                length: 1,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: 4 % 2 == 0
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Assets.image.gang.image(),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: BlocConsumer<CourseMainBloc, CourseMainState>(
              listener: (context,state){
                if(state.status == StateStatus.success){
                  CourseMainResponseModel model = state.data!;
                  for (var element in model.chapters!) {
                    element.isOpen ??= false;
                  }
                  navigatorKey.currentState!.popAndPushNamed(RoutePaths.courseInfo,
                      arguments: model);
                }
                if(state.status == StateStatus.fail){

                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    OutlinedPrimaryButton(
                      title: state.status == StateStatus.loading
                          ? ''
                          : "رفتن به صفحه دوره",
                      onClick: () {
                        context
                            .read<CourseMainBloc>()
                            .add(GetCourseMainInfo(courseId: widget.courseId));
                      },
                      fill: true,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: state.status == StateStatus.loading
                            ? const SpinKitThreeBounce(
                                color: primaryColor,
                                size: 36,
                              )
                            : SizedBox(),
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
