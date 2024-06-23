import 'package:ajhman/core/enum/state_status.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/model/roadmap_model.dart';
import 'package:ajhman/data/model/roadmap_view.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/loading_btn.dart';
import 'package:ajhman/ui/widgets/button/outline_primary_loading_button.dart';
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
import '../../../core/bloc/questions/questions_bloc.dart';
import '../../../core/routes/route_paths.dart';
import '../../../data/model/course_main_response_model.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).editTextFilled(),
                  borderRadius: DesignConfig.highBorderRadius),
              child: Column(
                children: [
                  PrimaryText(
                      text: widget.response.name.toString(),
                      style: Theme.of(context).textTheme.titleBold,
                      color: Theme.of(context).secondaryColor()),
                  SizedBox(
                    height: 8,
                  ),
                  PrimaryText(
                      text:
                          'در رودمپ زیر شما می‌توانید مسیر یادگیری خودتان را مشاهده کنید',
                      style: Theme.of(context).textTheme.rate,
                      color: Theme.of(context).progressText()),
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
                        items: widget.response.chapters,
                        item: (context, index) {
                          return Road(
                            index: index + 1,
                            length: widget.response.chapters!.length + 1,
                          );
                        }),
                  ],
                ),
                VerticalListView(
                    items: widget.response.chapters,
                    item: (context, index) {
                      RoadmapView view = getRoadMapContainer(true, null);
                      return Column(
                        crossAxisAlignment: (index + 1) % 2 == 0
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 36),
                                  width: 130,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          DesignConfig.mediumBorderRadius,
                                      color: Theme.of(context).white(),
                                      border: Border.all(color: view.color),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 32.0),
                                          child: PrimaryText(
                                            text: widget
                                                .response.chapters![index].name
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleBold,
                                            color: view.color,
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                          ),
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
                                                text:
                                                    "${widget.response.chapters![index].percent} از ۱۰۰",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .searchHint,
                                                color: Theme.of(context)
                                                    .pinTextFont())
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        widget.response.chapters![index]
                                                    .percent ==
                                                null
                                            ? const SizedBox()
                                            : Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: LinearProgress(
                                                  value: widget
                                                          .response
                                                          .chapters![index]
                                                          .percent!
                                                          .toDouble() /
                                                      100,
                                                  minHeight: 8,
                                                  backgroundColor: view.color
                                                      .withOpacity(0.5),
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
                  index: widget.response.chapters!.length - 1 % 2 == 0 ? 2 : 1,
                  length: null,
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment:
                        widget.response.chapters!.length - 1 % 2 == 0
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      Assets.image.gang.image(),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
