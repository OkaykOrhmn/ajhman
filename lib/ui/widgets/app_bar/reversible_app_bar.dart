import 'package:ajhman/main.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/color/colors.dart';
import '../../theme/text/text_styles.dart';

class ReversibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canBack;

  const ReversibleAppBar({super.key, required this.title, this.canBack = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Theme.of(context).surfacePrimaryColor(),
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Assets.icon.outline.arrowLeft.svg(color: Colors.transparent),
          PrimaryText(
              text: title,
              style: mThemeData.textTheme.headerBold,
              color: Colors.white),
          InkWell(
              onTap: canBack
                  ? () {
                      Navigator.of(context).pop();
                    }
                  : null,
              borderRadius: BorderRadius.circular(360),
              child: Assets.icon.outline.arrowLeft1
                  .svg(color: canBack ? Colors.white : Colors.transparent)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
