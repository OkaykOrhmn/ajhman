import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

import '../../theme/widget/design_config.dart';

class ToggleButtonTime extends StatefulWidget {
  final bool active;
  final String title;
  final Function()? click;

  const ToggleButtonTime(
      {super.key, required this.title, required this.active, this.click});

  @override
  State<ToggleButtonTime> createState() => _ToggleButtonTimeState();
}

class _ToggleButtonTimeState extends State<ToggleButtonTime> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.click,
      child: Container(
        width: 100,
        height: 46,
        decoration: BoxDecoration(
            color: widget.active ? Theme.of(context).white() : Theme.of(context).cardBackground(),
            borderRadius: DesignConfig.mediumBorderRadius,
            border: Border.all(
                color: widget.active ? Theme.of(context).primaryColor : backgroundColor100)),
        child: Center(
          child: PrimaryText(
            text : widget.title,
            style:  Theme.of(context).textTheme.headerLargeBold,
              color: widget.active ? Theme.of(context).primaryColor : Theme.of(context).progressText()
          ),
        ),
      ),
    );
  }
}
