import 'package:ajhman/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class HorizontalDashedLine extends StatelessWidget {
  const HorizontalDashedLine(
      {super.key,
      this.height = 1,
      required this.active,
      this.dashSize = 10.0,
      required this.dashed});
  final double height;
  final Color? active;
  final double dashSize;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    return dashed
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final boxWidth = constraints.constrainWidth();
              final dashWidth = dashSize;
              final dashHeight = height;
              final dashCount = (boxWidth / (1.2 * dashWidth)).floor();
              return Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: List.generate(dashCount, (_) {
                  return SizedBox(
                    width: dashWidth,
                    height: dashHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: active ?? backgroundColor,
                          borderRadius: BorderRadius.circular(360)),
                    ),
                  );
                }),
              );
            },
          )
        : Divider(
            thickness: height,
            color: active ?? backgroundColor,
          );
  }
}
