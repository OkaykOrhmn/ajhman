import 'package:ajhman/main.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_locale.dart';
import '../../../core/utils/language/bloc/language_bloc.dart';
import '../../../data/model/language.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/text/text_styles.dart';

class ReversibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ReversibleAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mThemeData.primaryColor,
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
              onTap: () {
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(360),
              child: Assets.icon.outline.arrowLeft1.svg(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
