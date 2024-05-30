import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/color/colors.dart';

class IconInfo extends StatelessWidget {
  final SvgGenImage icon;
  final String desc;

  const IconInfo({super.key, required this.icon, required this.desc});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon.svg(color: secondaryColor, width: 16, height: 16),
        const SizedBox(
          width: 4,
        ),
        PrimaryText(
            text: desc,
            style: themeData.textTheme.searchHint,
            maxLines: 1,
            color: grayColor600)
      ],
    );
  }
}
