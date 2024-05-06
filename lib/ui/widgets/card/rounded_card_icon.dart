import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/color/colors.dart';

class RoundedCardIcon extends StatelessWidget{
  final SvgGenImage svgGenImage;
  final bool active;
  const RoundedCardIcon({super.key, required this.svgGenImage, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(360),
        border: Border.all(color: primaryColor),
      ),
      padding: const EdgeInsets.all(12),
      child: svgGenImage.svg(color: active ? Colors.white  : primaryColor),
    );
  }
}