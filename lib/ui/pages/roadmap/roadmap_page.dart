// ignore_for_file: deprecated_member_use_from_same_package

import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/model/roadmap_model.dart';
import 'package:ajhman/data/model/roadmap_view.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/road.dart';
import 'package:ajhman/ui/widgets/text/marquee_text.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class RoadMapPage extends StatefulWidget {
  final RoadmapModel response;
  final String tag;

  const RoadMapPage({super.key, required this.response, required this.tag});

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
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).editTextFilled(),
                  borderRadius: DesignConfig.highBorderRadius),
              child: Column(
                children: [
                  PrimaryText(
                      text: widget.response.name.toString(),
                      style: Theme.of(context).textTheme.titleBold,
                      color: Theme.of(context).secondaryColor()),
                  const SizedBox(
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
            const SizedBox(
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
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: DesignConfig.aVeryHighBorderRadius,
                                topLeft: DesignConfig.aVeryHighBorderRadius,
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.zero),
                            gradient: LinearGradient(colors: [
                              Color(0xff4A4A4A),
                              Color(0xff575757),
                            ])),
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
                      RoadmapView view = widget
                                  .response.chapters![index].percent!
                                  .toDouble() ==
                              0
                          ? getLockRoadMapContainer
                          : getRoadMapContainer(true, null);
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
                                  padding: const EdgeInsets.only(top: 36),
                                  width: 130,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          DesignConfig.mediumBorderRadius,
                                      color: Theme.of(context).white(),
                                      border: Border.all(color: view.color),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        MarqueeText(
                                          text: widget
                                              .response.chapters![index].name
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleBold
                                              .copyWith(color: view.color),
                                          stop: const Duration(seconds: 2),
                                          textDirection:
                                              widget.tag == 'international'
                                                  ? TextDirection.rtl
                                                  : TextDirection.ltr,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        widget.response.chapters![index]
                                                    .percent ==
                                                null
                                            ? const SizedBox()
                                            : Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  widget
                                                              .response
                                                              .chapters![index]
                                                              .percent!
                                                              .toDouble() ==
                                                          100
                                                      ? Assets.icon
                                                          .outlineTickCircle
                                                          .svg(
                                                              color:
                                                                  successMain,
                                                              width: 12,
                                                              height: 12)
                                                      : widget
                                                                  .response
                                                                  .chapters![
                                                                      index]
                                                                  .percent!
                                                                  .toDouble() ==
                                                              0
                                                          ? Assets.icon.outline
                                                              .closeCircle
                                                              .svg(
                                                                  color:
                                                                      grayColor,
                                                                  width: 12,
                                                                  height: 12)
                                                          : Assets.icon.outline
                                                              .moreCircle
                                                              .svg(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .secondaryColor(),
                                                                  width: 12,
                                                                  height: 12),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  widget
                                                              .response
                                                              .chapters![index]
                                                              .percent!
                                                              .toDouble() ==
                                                          100
                                                      ? PrimaryText(
                                                          text: 'تکمیل شده',
                                                          style:
                                                              Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .searchHint,
                                                          color: successMain)
                                                      : widget
                                                                  .response
                                                                  .chapters![
                                                                      index]
                                                                  .percent!
                                                                  .toDouble() ==
                                                              0
                                                          ? Expanded(
                                                              child: PrimaryText(
                                                                  text:
                                                                      'این فصل را هنوز شروع نکرده‌اید',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .searchHint,
                                                                  color:
                                                                      grayColor),
                                                            )
                                                          : PrimaryText(
                                                              text:
                                                                  'در حال یادگیری',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .searchHint,
                                                              color: Theme.of(
                                                                      context)
                                                                  .secondaryColor())
                                                ],
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
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
