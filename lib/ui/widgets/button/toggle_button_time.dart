import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            color: widget.active ? Colors.white : backgroundColor100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: widget.active ? primaryColor : backgroundColor100)),
        child: Center(
          child: Text(
            widget.title,
            style: AppTextStyles.headline3
                .copyWith(color: widget.active ? primaryColor : grayColor900),
          ),
        ),
      ),
    );
  }
}
