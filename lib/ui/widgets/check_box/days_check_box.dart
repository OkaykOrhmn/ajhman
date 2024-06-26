import 'package:flutter/material.dart';

import '../../theme/color/colors.dart';

class DaysCheckBox extends StatefulWidget {
  final bool value;
  final Function(bool?)? onChange;


  const DaysCheckBox({super.key, required this.value, this.onChange});

  @override
  State<DaysCheckBox> createState() => _DaysCheckBoxState();
}

class _DaysCheckBoxState extends State<DaysCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        side:  BorderSide(
          color: Theme.of(context).cardText(),
        ),
        activeColor: Theme.of(context).primaryColor,
        checkColor: Theme.of(context).black(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        value: widget.value,
        onChanged: (val) {
          widget.onChange!(val);
        });
  }
}
