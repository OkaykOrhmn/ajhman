import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../button/primary_button.dart';
import '../text/primary_text.dart';

class NewCourseCard extends StatefulWidget {
  final int index;

  const NewCourseCard({super.key, required this.index});

  @override
  State<NewCourseCard> createState() => _RecentCurseCardState();
}

class _RecentCurseCardState extends State<NewCourseCard> {
  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final items = [1, 2, 3, 4];
    final ThemeData themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _image(
            "https://s3-alpha-sig.figma.com/img/af96/c5c5/f30aa9b307c9cea4157fd83e8241313f?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cUzaT649xZG-13eTH-mOoyfpa4N3X7e8LPaEavVJgnMknI6xj62nO7ddzNjkRzGUd-i3sFIoEURHBNcN7ZJ7gfRCABnjqRqPoOsC2ysgIXSo3hM48I8UgWJDcDDi7D8vSkl4Y-qpsaEpXiON~caKrz1cc3VEuvyv4jNqFEBGjjXQkDYsB3d0FzuGI5M6PhCK9JF9vRY1fFF4OdD6M2hV~S1t8zVmyGYYmDBANz89cKQUa1Z5fqwW8P7SxmNojwPa2Qiszw-2f05JM9FxrzVuobtBkHdV9epFixt~r39-bl-QJEaj9tKk-BOTUb7jHA59CLZguJEgkAjE~af33dbopw__",
            "3.4"),
        _title(themeData),
        _infoes(themeData),
        const SizedBox(
            width: double.infinity,
            child: PrimaryButton(title: "ورود به جلسه")),
      ],
    );
  }

  Column _infoes(ThemeData themeData) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconInfo(icon: Assets.icon.outline.moreCircle, desc: "۴۵۴۷۶۸۶"),
            ),
            Expanded(
              child: IconInfo(icon: Assets.icon.outline.microphone, desc: "محتوای صوتی"),
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
              child: IconInfo(icon: Assets.icon.outline.moreCircle, desc: "۱٬۳۴۲ فراگیر"),
            ),
            Expanded(
              child: IconInfo(icon: Assets.icon.outline.clock, desc: "۵۶ ساعت"),
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
              child: IconInfo(icon: Assets.icon.outline.chart, desc: "سطح متوسط"),
            ),
            Expanded(
              child: IconInfo(icon: Assets.icon.outline.note2, desc: "مدیریت کسب و کار"),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Padding _title(ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: (themeData.textTheme.titleBold.fontSize! * 3),
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 190,
        ),
        child: PrimaryText(
          text: "جایگاه مدیریت دانش و فناوری اطلاعات در سازمان یادگیرنده",
          style: themeData.textTheme.titleBold,
          textAlign: TextAlign.start,
          color: grayColor900,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _image(String src, String rate) {
    ThemeData themeData = Theme.of(context);
    return Stack(
      children: [
        PrimaryImageNetwork(src: src, aspectRatio: 16 / 9),
        Positioned(
            top: 4,
            right: 4,
            left: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _bookMark(),
                _rateBar(rate),
              ],
            ))
      ],
    );
  }

  Container _rateBar(String rate) {
    ThemeData themeData = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white, borderRadius: DesignConfig.highBorderRadius),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: PrimaryText(
                  text: rate,
                  style: themeData.textTheme.searchHint,
                  color: grayColor700),
            ),
            const SizedBox(
              width: 2,
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

  Container _bookMark() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(5),
      child: Assets.icon.outlineArchive
          .svg(width: 14, height: 14, color: primaryColor),
    );
  }
}
