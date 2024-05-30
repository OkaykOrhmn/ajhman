import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';

class TitleDivider extends StatelessWidget {
  final String title;
  final Function()? btn;

  const TitleDivider({super.key, required this.title, this.btn});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(
              text: title,
              style: themeData.textTheme.titleBold,
              color: primaryColor900),
          btn != null
              ? InkWell(
                  onTap: btn,
                  borderRadius: DesignConfig.lowBorderRadius,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryText(
                        text: "مشاهده همه",
                        style: themeData.textTheme.searchHint,
                        color: primaryColor,
                      ),
                      Assets.icon.outline.arrowLeft
                          .svg(color: primaryColor, width: 16, height: 16)
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
