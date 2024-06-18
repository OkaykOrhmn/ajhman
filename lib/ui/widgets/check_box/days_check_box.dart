import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/color/colors.dart';

class DaysCheckBox extends StatefulWidget {
  final bool value;
  final Function(bool?)? onChange;


  DaysCheckBox({super.key, required this.value, this.onChange});

  @override
  State<DaysCheckBox> createState() => _DaysCheckBoxState();
}

class _DaysCheckBoxState extends State<DaysCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        side: const BorderSide(
          color: grayColor700,
        ),
        activeColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        value: widget.value,
        onChanged: (val) {
          widget.onChange!(val);
        });
  }
}
