import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/colors.dart';
import '../../theme/design_config.dart';

class TitleDivider extends StatelessWidget {
  final String title;
  final Function()? btn;
  final bool hasPadding;

  const TitleDivider(
      {super.key, required this.title, this.btn, this.hasPadding = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(hasPadding ? 16 : 0, 0, hasPadding ? 16 : 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(
              text: title,
              style: Theme.of(context).textTheme.titleBold,
              color: Theme.of(context).headText()),
          btn != null
              ? InkWell(
                  onTap: btn,
                  borderRadius: DesignConfig.lowBorderRadius,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryText(
                        text: "مشاهده همه",
                        style: Theme.of(context).textTheme.searchHint,
                        color: Theme.of(context).primaryColor,
                      ),
                      Assets.icon.outline.arrowLeft.svg(
                          color: Theme.of(context).primaryColor,
                          width: 16,
                          height: 16)
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
