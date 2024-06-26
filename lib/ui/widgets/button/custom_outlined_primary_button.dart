import 'package:flutter/material.dart';

import '../../theme/widget/design_config.dart';

class CustomOutlinedPrimaryButton extends StatelessWidget {
  final Widget child;
  final Function()? onClick;
  final bool fill;
  final Color? color;

  const CustomOutlinedPrimaryButton(
      {super.key,
      required this.child,
      this.onClick,
      this.fill = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? MediaQuery.sizeOf(context).width : null,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              side: BorderSide(color: color ?? Theme.of(context).primaryColor),
              shape: const RoundedRectangleBorder(
                borderRadius: DesignConfig.mediumBorderRadius,
              )),
          onPressed: onClick,
          child: Center(
            child: child,
          )),
    );
  }
}
