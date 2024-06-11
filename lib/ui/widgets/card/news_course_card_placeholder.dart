import 'package:ajhman/core/cubit/mark/mark_cubit.dart';
import 'package:ajhman/core/cubit/mark/mark_cubit.dart';
import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/args/course_main_args.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../button/primary_button.dart';
import '../text/primary_text.dart';

class NewCourseCardPlaceholder extends StatefulWidget {
  final CardType type;
  final EdgeInsetsGeometry? padding;

  const NewCourseCardPlaceholder({super.key,
    this.padding,
    required this.type});

  @override
  State<NewCourseCardPlaceholder> createState() => _RecentCurseCardState();
}

class _RecentCurseCardState extends State<NewCourseCardPlaceholder> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Center(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.defaultShadow,
                color: Colors.white),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultPlaceHolder(child: _image("", "3.4"))
                ,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title(),
                      _infoes(),
                      _footer(),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _footer() {
    switch (widget.type) {
      case CardType.onLearning:
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 1,
                color: backgroundColor600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: MediaQuery
                            .sizeOf(context)
                            .width / 5,
                        child: DefaultPlaceHolder(child: LinearProgress(value: 0.8, minHeight: 8))),
                    SizedBox(
                      width: 8,
                    ),
                    DefaultPlaceHolder(
                      child: PrimaryText(
                          text: "response.progress.toString()",
                          style: mThemeData.textTheme.navbarTitle,
                          color: grayColor900),
                    ),
                  ],
                ),
                DefaultPlaceHolder(child: PrimaryButton(title: "دریافت گواهینامه"))
              ],
            )
          ],
        );

      case CardType.normal:
        return DefaultPlaceHolder(
          child: PrimaryButton(
            fill: true,
            title: "ورود به جلسه",
            onClick: () {
            },
          ),
        );

      case CardType.completed:
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 1,
                color: backgroundColor600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    DefaultPlaceHolder(
                      child: PrimaryText(
                          text: "امتیاز شما: ",
                          style: mThemeData.textTheme.navbarTitle,
                          color: grayColor600),
                    ),
                    DefaultPlaceHolder(
                      child: PrimaryText(
                          text: "{response.score} امتیاز",
                          style: mThemeData.textTheme.navbarTitleBold,
                          color: primaryColor),
                    ),
                  ],
                ),
                DefaultPlaceHolder(child: PrimaryButton(title: "دریافت گواهینامه"))
              ],
            )
          ],
        );
    }
  }

  Column _infoes() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: DefaultPlaceHolder(
                  child: Expanded(
                    child: IconInfo(
                        icon: Assets.icon.outline.moreCircle, desc: "۴۵۴۷۶۸۶"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: DefaultPlaceHolder(
                  child: Expanded(
                    child: IconInfo(
                        icon: Assets.icon.outline.microphone, desc: "محتوای صوتی"),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: DefaultPlaceHolder(
                  child: Expanded(
                    child: IconInfo(
                        icon: Assets.icon.outline.moreCircle, desc: "۴۵۴۷۶۸۶"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: DefaultPlaceHolder(
                  child: Expanded(
                    child: IconInfo(
                        icon: Assets.icon.outline.microphone, desc: "محتوای صوتی"),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: DefaultPlaceHolder(
                  child: Expanded(
                    child: IconInfo(
                        icon: Assets.icon.outline.moreCircle, desc: "۴۵۴۷۶۸۶"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: DefaultPlaceHolder(
                  child: Expanded(
                    child: IconInfo(
                        icon: Assets.icon.outline.microphone, desc: "محتوای صوتی"),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Padding _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: DefaultPlaceHolder(
        child: PrimaryText(
          text: "response.name.toString()",
          style: mThemeData.textTheme.titleBold,
          textAlign: TextAlign.start,
          color: grayColor900,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _image(String src, String rate) {
    return Stack(
      children: [
        PrimaryImageNetwork(src: src, aspectRatio: 16 / 9),
        // Positioned(
        //     top: 12,
        //     right: 12,
        //     left: 12,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         _bookMark(),
        //         _rateBar(rate),
        //       ],
        //     ))
      ],
    );
  }

  Container _rateBar(String rate) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white, borderRadius: DesignConfig.highBorderRadius),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: PrimaryText(
                  text: rate,
                  style: mThemeData.textTheme.searchHint,
                  color: grayColor700),
            ),
            const SizedBox(
              width: 4,
            ),
            const Icon(
              CupertinoIcons.star_fill,
              size: 14,
              color: goldColor,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _bookMark() {
  //   // return BlocProvider(
  //   //   create: (context) => MarkCubit(response.marked!),
  //   //   child: BlocBuilder<MarkCubit, MarkState>(
  //   //       builder: (context, state) {
  //           // response.marked = state.mark;
  //           return InkWell(
  //               onTap: () {
  //                 // final event = context.read<MarkCubit>();
  //                 // if (state.mark) {
  //                 //   event.deleteMark(response.id!);
  //                 // } else {
  //                 //   event.postMark(response.id!);
  //                 // }
  //               },
  //               child: Container(
  //                 decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 width: 28,
  //                 height: 28,
  //                 child: Center(
  //                   child:
  //                   // state.mark
  //                   //     ? Assets.icon.boldArchive
  //                   //     .svg(width: 18, height: 18, color: primaryColor)
  //                   //     :
  //                   Assets.icon.outlineArchive
  //                       .svg(width: 18, height: 18, color: primaryColor),
  //                 ),
  //               ));
  //         // }),
  //   // );
  // }
}
