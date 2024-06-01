import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/progress/linear_progress.dart';
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../text/primary_text.dart';

class RecentCourseCard extends StatefulWidget {
  final int index;

  const RecentCourseCard({super.key, required this.index});

  @override
  State<RecentCourseCard> createState() => _RecentCourseCardState();
}

class _RecentCourseCardState extends State<RecentCourseCard> {
  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final items = [1, 2, 3, 4];

    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _image(
                "https://s3-alpha-sig.figma.com/img/af96/c5c5/f30aa9b307c9cea4157fd83e8241313f?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cUzaT649xZG-13eTH-mOoyfpa4N3X7e8LPaEavVJgnMknI6xj62nO7ddzNjkRzGUd-i3sFIoEURHBNcN7ZJ7gfRCABnjqRqPoOsC2ysgIXSo3hM48I8UgWJDcDDi7D8vSkl4Y-qpsaEpXiON~caKrz1cc3VEuvyv4jNqFEBGjjXQkDYsB3d0FzuGI5M6PhCK9JF9vRY1fFF4OdD6M2hV~S1t8zVmyGYYmDBANz89cKQUa1Z5fqwW8P7SxmNojwPa2Qiszw-2f05JM9FxrzVuobtBkHdV9epFixt~r39-bl-QJEaj9tKk-BOTUb7jHA59CLZguJEgkAjE~af33dbopw__"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("مهارت‌های رهبری (Leadership) و تاثیرگذاری بر افراد"),
                  const SizedBox(
                    height: 8,
                  ),
                  _infoes(),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 100,
                    decoration:
                        BoxDecoration(boxShadow: DesignConfig.defaultShadow),
                    child: const LinearProgress(value: 0.8, minHeight: 8),
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
            bottom: 18,
            left: 20,
            child: PrimaryText(
              text: "23/40",
              style: mThemeData.textTheme.searchHint,
              color: grayColor900,
            ))
      ],
    );
  }

  Column _infoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconInfo(icon: Assets.icon.outline.chart, desc: "سطح پیشرفته"),
        const SizedBox(
          height: 8,
        ),
        IconInfo(icon: Assets.icon.outline.note2, desc: "توسعه فردی")
      ],
    );
  }

  Container _title(String text) {

    return Container(
      height: (mThemeData.textTheme.title.fontSize! * 3),
      constraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 190,
      ),
      child: PrimaryText(
        text: text,
        style: mThemeData.textTheme.title,
        textAlign: TextAlign.start,
        color: grayColor900,
        maxLines: 2,
      ),
    );
  }

  Widget _image(String src) {
    return PrimaryImageNetwork(src: src, aspectRatio: 1/1);
  }
}
