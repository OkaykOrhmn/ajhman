import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/text/text_styles.dart';
import '../../theme/widget/app_buttons_style.dart';

class LittlePrimaryButton extends StatelessWidget {
  final IconData icon;
  final Function()? onClick;

  LittlePrimaryButton({required this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),

        ),
        child: Center(
          child: Icon(icon,color: Colors.white,size: 16,),
        ),
      ),
    );
  }
}
