import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/states/default_place_holder.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/design_config.dart';
import '../button/primary_button.dart';
import '../text/primary_text.dart';

class NewCourseCardPlaceholder extends StatefulWidget {
  final CardType type;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  const NewCourseCardPlaceholder(
      {super.key, this.padding, required this.type, this.width, this.height});

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
      child: Column(
        children: [
          Center(
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
                    DefaultPlaceHolder(child: _image("", "3.4")),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _title(),
                          // _infoes(),
                          _footer(),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    switch (widget.type) {
      case CardType.onLearning:
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
                        child: const DefaultPlaceHolder(
                            child: LinearProgress(value: 0.8, minHeight: 8))),
                    const SizedBox(
                      width: 8,
                    ),
                    DefaultPlaceHolder(
                      child: PrimaryText(
                          text: "response.progress.toString()",
                          style: Theme.of(context).textTheme.navbarTitle,
                          color: Theme.of(context).progressText()),
                    ),
                  ],
                ),
                const DefaultPlaceHolder(
                    child: PrimaryButton(title: "دریافت گواهینامه"))
              ],
            )
          ],
        );

      case CardType.normal:
        return DefaultPlaceHolder(
          child: PrimaryButton(
            fill: true,
            title: "ورود به جلسه",
            onClick: () {},
          ),
        );

      case CardType.completed:
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
                    DefaultPlaceHolder(
                      child: PrimaryText(
                          text: "امتیاز شما: ",
                          style: Theme.of(context).textTheme.navbarTitle,
                          color: Theme.of(context).editTextFont()),
                    ),
                    DefaultPlaceHolder(
                      child: PrimaryText(
                          text: "{response.score} امتیاز",
                          style: Theme.of(context).textTheme.navbarTitleBold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                const DefaultPlaceHolder(
                    child: PrimaryButton(title: "دریافت گواهینامه"))
              ],
            )
          ],
        );
      case CardType.notLearned:
        return const DefaultPlaceHolder(
            child: PrimaryButton(title: "دریافت گواهینامه"));
    }
  }

  Padding _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: DefaultPlaceHolder(
        child: PrimaryText(
          text: "response.name.toString()",
          style: Theme.of(context).textTheme.titleBold,
          textAlign: TextAlign.start,
          color: Theme.of(context).progressText(),
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

  /* Container _rateBar(String rate) {
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
  */

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
