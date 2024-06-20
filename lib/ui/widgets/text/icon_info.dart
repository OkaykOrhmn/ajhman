import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../main.dart';
import '../../theme/color/colors.dart';

class IconInfo extends StatelessWidget {
  final SvgGenImage icon;
  final String desc;

  const IconInfo({super.key, required this.icon, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon.svg(color:  Theme.of(context).secondaryColor(), width: 16, height: 16),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: PrimaryText(
              text: desc,
              textAlign: TextAlign.start,
              style: mThemeData.textTheme.searchHint,
              maxLines: 1,
              color: Theme.of(context).editTextFont()),
        )
      ],
    );
  }
}
