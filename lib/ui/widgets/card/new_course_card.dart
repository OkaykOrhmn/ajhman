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
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/course_types.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../button/primary_button.dart';
import '../text/primary_text.dart';

class NewCourseCard extends StatefulWidget {
  final int index;
  final CardType type;
  final EdgeInsetsGeometry? padding;
  final NewCourseCardModel response;

  const NewCourseCard(
      {super.key,
      required this.index,
      this.padding,
      required this.type,
      required this.response});

  @override
  State<NewCourseCard> createState() => _RecentCurseCardState();
}

class _RecentCurseCardState extends State<NewCourseCard> {
  late NewCourseCardModel response;

  @override
  void initState() {
    response = widget.response;

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
                _image(getImageUrl(response.image.toString()), "3.4"),
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
        final p = getProgressCard(response.progress.toString());
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
                        width: MediaQuery.sizeOf(context).width / 5,
                        child: LinearProgress(value: p, minHeight: 8)),
                    SizedBox(
                      width: 8,
                    ),
                    PrimaryText(
                        text: response.progress.toString(),
                        style: mThemeData.textTheme.navbarTitle,
                        color: grayColor900),
                  ],
                ),
                PrimaryButton(title: "دریافت گواهینامه")
              ],
            )
          ],
        );

      case CardType.normal:
        return PrimaryButton(
          fill: true,
          title: "ورود به جلسه",
          onClick: () {
            navigatorKey.currentState!.pushNamed(RoutePaths.courseMain,
                arguments: CourseMainArgs(courseId: response.id!));
          },
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
                    PrimaryText(
                        text: "امتیاز شما: ",
                        style: mThemeData.textTheme.navbarTitle,
                        color: grayColor600),
                    PrimaryText(
                        text: "${response.score} امتیاز",
                        style: mThemeData.textTheme.navbarTitleBold,
                        color: primaryColor),
                  ],
                ),
                PrimaryButton(title: "دریافت گواهینامه")
              ],
            )
          ],
        );
    }
  }

  Column _infoes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.user,
                  desc: "${response.users.toString()} فراگیر"),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.clock,
                  desc: "${response.time.toString()} ساعت"),
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
              child: IconInfo(
                  icon: Assets.icon.outline.chart,
                  desc: "سطح ${getLevel(response.level)}"),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.note2,
                  desc: response.category!.name.toString()),
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
      child: Container(
        height: (mThemeData.textTheme.titleBold.fontSize! * 3),
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 190,
        ),
        child: PrimaryText(
          text: response.name.toString(),
          style: mThemeData.textTheme.titleBold,
          textAlign: TextAlign.start,
          color: grayColor900,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _image(String src, String rate) {
    CourseTypes courseTypes = getType(widget.response.type);

    return Stack(
      children: [
        PrimaryImageNetwork(src: src, aspectRatio: 16 / 9),
        Positioned(
            top: 12,
            right: 12,
            left: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _bookMark(),
                _rateBar(rate),
              ],
            )),
        Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  boxShadow: DesignConfig.lowShadow,
                  borderRadius: DesignConfig.highBorderRadius),
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgGenImage(courseTypes.icon)
                      .svg(color: secondaryColor, width: 14, height: 14),
                  SizedBox(width: 8,),
                  PrimaryText(text: courseTypes.title, style: mThemeData.textTheme.searchHint, color: secondaryColor)
                ],
              ),
            ))
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

  Widget _bookMark() {
    return BlocProvider(
      create: (context) => MarkCubit(response.marked!),
      child: BlocBuilder<MarkCubit, MarkState>(builder: (context, state) {
        response.marked = state.mark;
        return InkWell(
            onTap: () {
              final event = context.read<MarkCubit>();
              if (state.mark) {
                event.deleteMark(response.id!);
              } else {
                event.postMark(response.id!);
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              width: 28,
              height: 28,
              child: Center(
                child: state.mark
                    ? Assets.icon.boldArchive
                        .svg(width: 18, height: 18, color: primaryColor)
                    : Assets.icon.outlineArchive
                        .svg(width: 18, height: 18, color: primaryColor),
              ),
            ));
      }),
    );
  }
}
