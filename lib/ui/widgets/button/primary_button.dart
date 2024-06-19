import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

import '../../theme/text/text_styles.dart';
import '../../theme/widget/design_config.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final bool fill;
  final double? height;

  const PrimaryButton(
      {super.key, required this.title, this.onClick, this.fill = false, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? MediaQuery.sizeOf(context).width : null,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: secondaryColor,
              shape: const RoundedRectangleBorder(borderRadius: DesignConfig.mediumBorderRadius)),
          onPressed: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PrimaryText(
              text: title,
              style: Theme.of(context).textTheme.searchHint,
              color: Colors.white,
            ),
          )),
    );
  }
}
