import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalDashedLine extends StatelessWidget {
  const VerticalDashedLine(
      {super.key,
      this.width = 1, this.active,
      this.dashSize = 10.0,
      required this.dashed});

  final double width;
  final Color? active;
  final double dashSize;
  final bool dashed;

  @override
  Widget build(BuildContext context) {

    return dashed
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final boxHeight = constraints.constrainHeight();
              final dashWidth = width;
              final dashHeight = dashSize;
              final dashCount = (boxHeight / (1.5 * dashHeight)).floor();
              return Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.vertical,
                children: List.generate(dashCount, (_) {
                  return SizedBox(
                    width: dashWidth,
                    height: dashHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: active?? backgroundColor,
                          borderRadius: BorderRadius.circular(360)),
                    ),
                  );
                }),
              );
            },
          )
        : VerticalDivider(
            thickness: width,
            color: active?? backgroundColor,
          );
  }
}
