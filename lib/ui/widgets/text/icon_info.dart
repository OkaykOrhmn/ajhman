// ignore_for_file: deprecated_member_use_from_same_package

import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class IconInfo extends StatelessWidget {
  final SvgGenImage icon;
  final String desc;
  final bool eng;

  const IconInfo(
      {super.key, required this.icon, required this.desc, this.eng = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon.svg(
            color: Theme.of(context).secondaryColor(), width: 16, height: 16),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: PrimaryText(
              text: desc,
              textAlign: TextAlign.start,
              style: eng
                  ? Theme.of(context).textTheme.searchHintEng
                  : Theme.of(context).textTheme.searchHint,
              maxLines: 1,
              color: Theme.of(context).editTextFont()),
        )
      ],
    );
  }
}
