import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

import '../../theme/text/text_styles.dart';
import '../../theme/widget/design_config.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final bool fill;

  const OutlinedPrimaryButton(
      {super.key, required this.title, this.onClick, this.fill = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? MediaQuery.sizeOf(context).width : null,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              side:  BorderSide(color: Theme.of(context).primaryColor),
              shape: const RoundedRectangleBorder(
                borderRadius:DesignConfig.mediumBorderRadius,
              )),
          onPressed: onClick,
          child: PrimaryText(
           text:  title,
            color: Theme.of(context).primaryColor,
            style: AppTextStyles.outlinedPrimaryButtonText,
          )),
    );
  }
}
