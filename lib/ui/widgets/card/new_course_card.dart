
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/home/selected_index_cubit.dart';
import '../../../core/cubit/mark/mark_cubit.dart';
import '../../../core/enum/course_types.dart';
import '../../../core/routes/route_paths.dart';
import '../../../core/utils/language/bloc/language_bloc.dart';
import '../../../core/utils/usefull_funcs.dart';
import '../../../data/args/course_main_args.dart';
import '../../../data/model/cards/new_course_card_model.dart';
import '../../../data/model/language.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/widget/design_config.dart';
import '../button/primary_button.dart';
import '../image/primary_image_network.dart';
import '../progress/linear_progress.dart';
import '../text/icon_info.dart';
import '../text/primary_text.dart';

class NewCourseCard extends StatefulWidget {
  final int index;
  final EdgeInsetsGeometry? padding;
  final NewCourseCardModel response;
  final double? width;
  final double? height;

  const NewCourseCard(
      {super.key,
      required this.index,
      this.padding,
      required this.response,
      this.width,
      this.height});

  @override
  State<NewCourseCard> createState() => _RecentCurseCardState();
}

class _RecentCurseCardState extends State<NewCourseCard> {
  late NewCourseCardModel response;
  bool isInternational = false;

  @override
  void initState() {
    response = widget.response;
    if (widget.response.tag != null && widget.response.tag == "international" ||
        context.read<LanguageBloc>().state.selectedLanguage ==
            Language.english) {
      setState(() {
        isInternational = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InkWell(
        onTap: () {
          navigatorKey.currentState!.pushNamed(RoutePaths.courseMain,
              arguments: CourseMainArgs(courseId: response.id));
        },
        child: Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: DesignConfig.highBorderRadius,
                    boxShadow: DesignConfig.lowShadow,
                    color: Theme.of(context).white()),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _image(getImageUrl(response.image.toString()), "3.4"),
                    Directionality(
                      textDirection: isInternational
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _title(),
                            response.category!.id == 6
                                ? _bookInfoes()
                                : _infoes(),
                            _footer(),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _footer() {
    switch (response.status.toString()) {
      case "learning":
        final p = getProgressCard(response.progress.toString());
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 1,
                color: Theme.of(context).disable(),
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
                    const SizedBox(
                      width: 8,
                    ),
                    PrimaryText(
                        text: response.progress.toString(),
                        style: Theme.of(context).textTheme.navbarTitle,
                        color: Theme.of(context).progressText()),
                  ],
                ),
                PrimaryButton(
                    title: "ادامه یادگیری",
                    onClick: () {
                      navigatorKey.currentState!.pushNamed(
                          RoutePaths.courseMain,
                          arguments: CourseMainArgs(courseId: response.id));
                    })
              ],
            )
          ],
        );

      case "not learned":
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 1,
                color: Theme.of(context).disable(),
              ),
            ),
            PrimaryButton(
              fill: true,
              title: response.registered! ? "ورود" : "ثبت‌نام",
              onClick: response.canStart != null && response.canStart!
                  ? () {
                      navigatorKey.currentState!.pushNamed(
                          RoutePaths.courseMain,
                          arguments: CourseMainArgs(courseId: response.id!));
                    }
                  : null,
            ),
          ],
        );

      case "learned":
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 1,
                color: Theme.of(context).disable(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    PrimaryText(
                        text: "امتیاز شما: ",
                        style: Theme.of(context).textTheme.navbarTitle,
                        color: Theme.of(context).editTextFont()),
                    PrimaryText(
                        text: "${response.score}",
                        style: Theme.of(context).textTheme.navbarTitleBold,
                        color: Theme.of(context).primaryColor),
                  ],
                ),
                PrimaryButton(
                  title: "دریافت گواهینامه",
                  onClick: () {
                    context
                        .read<SelectedIndexCubit>()
                        .changeSelectedIndex(1, "گنجینه من");
                  },
                )
              ],
            )
          ],
        );

      default:
        return const SizedBox();
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
                  desc:
                      "${response.users.toString()} ${isInternational ? 'Participants' : 'فراگیر'}"),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.clock,
                  desc:
                      "${response.time.toString()} ${isInternational ? 'Hours' : 'ساعت'}"),
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
                  desc:
                      "${isInternational ? 'Level' : 'سطح'} ${getLevel(response.level, isInternational)}"),
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

  Column _bookInfoes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.edit2,
                  desc: response.writer.toString()),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.note2,
                  desc: response.pages.toString()),
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
                  icon: Assets.icon.outline.book,
                  desc: response.publisher.toString()),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.ranking,
                  desc: response.topic.toString()),
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
                  icon: Assets.icon.outline.microphone,
                  desc:
                      "خلاصه صوتی ${response.audio != null && response.audio!.isEmpty ? 'ن' : ''}دارد"),
            ),
            Expanded(
              child: IconInfo(
                  icon: Assets.icon.outline.user,
                  desc: '${response.users} فراگیر'),
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
        height: (Theme.of(context).textTheme.titleBold.fontSize! * 3),
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 190,
        ),
        child: PrimaryText(
          text: response.name.toString(),
          style: Theme.of(context).textTheme.titleBold,
          textAlign: TextAlign.start,
          color: Theme.of(context).progressText(),
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
                // _rateBar(rate),
              ],
            )),
        response.category!.id == 6
            ? const SizedBox()
            : Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).white().withOpacity(0.5),
                      boxShadow: DesignConfig.lowShadow,
                      borderRadius: DesignConfig.highBorderRadius),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgGenImage(courseTypes.icon).svg(
                          color: Theme.of(context).secondaryColor(),
                          width: 14,
                          height: 14),
                      const SizedBox(
                        width: 8,
                      ),
                      PrimaryText(
                          text: isInternational
                              ? courseTypes.type
                              : courseTypes.title,
                          style: Theme.of(context).textTheme.searchHint,
                          color: Theme.of(context).secondaryColor())
                    ],
                  ),
                )),
        widget.response.expiresAt == null
            ? const SizedBox()
            : Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).white().withOpacity(0.5),
                      boxShadow: DesignConfig.lowShadow,
                      borderRadius: DesignConfig.highBorderRadius),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icon.outline.calendar.svg(
                          color: Theme.of(context).secondaryColor(),
                          width: 14,
                          height: 14),
                      const SizedBox(
                        width: 8,
                      ),
                      PrimaryText(
                          text:
                              "مهلت تا ${getIsoTimeMonthAndDay(response.expiresAt.toString())}",
                          style: Theme.of(context).textTheme.searchHint,
                          color: Theme.of(context).secondaryColor())
                    ],
                  ),
                )),
      ],
    );
  }

  Container _rateBar(String rate) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).white(),
          borderRadius: DesignConfig.highBorderRadius),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: PrimaryText(
                  text: rate,
                  style: Theme.of(context).textTheme.searchHint,
                  color: Theme.of(context).cardText()),
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
              decoration: BoxDecoration(
                color: Theme.of(context).white().withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              width: 28,
              height: 28,
              child: Center(
                child: state.mark
                    ? Assets.icon.boldArchive.svg(
                        width: 18,
                        height: 18,
                        color: Theme.of(context).primaryColor)
                    : Assets.icon.outlineArchive.svg(
                        width: 18,
                        height: 18,
                        color: Theme.of(context).primaryColor),
              ),
            ));
      }),
    );
  }
}
