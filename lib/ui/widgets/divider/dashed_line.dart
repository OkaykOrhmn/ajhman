import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget {
  const MySeparator(
      {Key? key,
      this.height = 1,
      required this.active,
      this.dashSize = 10.0,
      required this.dashed})
      : super(key: key);
  final double height;
  final bool active;
  final double dashSize;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    final Color color = active ? primaryColor : silverColor;

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
                          color: color,
                          borderRadius: BorderRadius.circular(360)),
                    ),
                  );
                }),
              );
            },
          )
        : Divider(
            thickness: height,
            color: color,
          );
  }
}
