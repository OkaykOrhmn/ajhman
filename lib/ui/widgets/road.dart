import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/divider/vertical_dashed_line.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'divider/horizontal_dashed_line.dart';

class Road extends StatefulWidget {
  final int index;
  final int? length;
  final double? height;

  const Road(
      {super.key, required this.index, required this.length, this.height});

  @override
  State<Road> createState() => _RoadState();
}

class _RoadState extends State<Road> {
  late bool isEven;

  @override
  void initState() {
    isEven = widget.index % 2 == 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80,
        height: widget.height ?? 130,
        child: Stack(
          children: [
            top(),
            isEven ? left() : right(),
          ],
        ),
      ),
    );
  }

  Positioned right() {
    return Positioned(
        right: 0,
        bottom: 0,
        top: 0,
        child: Stack(
          children: [
            Container(
              width: 25,
              padding: const EdgeInsets.only(bottom: 0, top: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: widget.length == null
                        ? DesignConfig.aVeryHighBorderRadius
                        : Radius.zero,
                    bottomRight: widget.length == null
                        ? DesignConfig.aVeryHighBorderRadius
                        : Radius.zero,
                    topRight: isEven
                        ? Radius.zero
                        : DesignConfig.aVeryHighBorderRadius,
                    topLeft: isEven
                        ? DesignConfig.aVeryHighBorderRadius
                        : Radius.zero,
                  ),
                  gradient: const LinearGradient(colors: [
                    Color(0xff4A4A4A),
                    Color(0xff575757),
                  ])),
              child: const VerticalDashedLine(
                width: 2,
                active: Colors.white,
                dashed: true,
                dashSize: 8,
              ),
            ),
            Positioned(
                top: 11.5,
                right: 11.5,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: const Border(
                        top: BorderSide(color: Colors.white, width: 2),
                        right: BorderSide(color: Colors.white, width: 2),
                      )),
                ))
          ],
        ));
  }

  Positioned left() {
    return Positioned(
        left: 0,
        bottom: 0,
        top: 0,
        child: Stack(
          children: [
            Container(
              width: 25,
              padding: const EdgeInsets.only(bottom: 11.5, top: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.zero,
                      topLeft: DesignConfig.aVeryHighBorderRadius,
                      bottomLeft: widget.length == null
                          ? DesignConfig.aVeryHighBorderRadius
                          : Radius.zero,
                      bottomRight: widget.length == null
                          ? DesignConfig.aVeryHighBorderRadius
                          : Radius.zero),
                  gradient: const LinearGradient(colors: [
                    Color(0xff4A4A4A),
                    Color(0xff575757),
                  ])),
              child: const VerticalDashedLine(
                width: 2,
                active: Colors.white,
                dashed: true,
                dashSize: 8,
              ),
            ),
            Positioned(
                top: 11.5,
                left: 11.5,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: const Border(
                        top: BorderSide(color: Colors.white, width: 2),
                        left: BorderSide(color: Colors.white, width: 2),
                      )),
                ))
          ],
        ));
  }

  Positioned top() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Stack(
          children: [
            Container(
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 11.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: isEven
                        ? Radius.zero
                        : DesignConfig.aVeryHighBorderRadius,
                    topLeft: isEven
                        ? DesignConfig.aVeryHighBorderRadius
                        : Radius.zero,
                    bottomLeft: DesignConfig.aVeryHighBorderRadius,
                    bottomRight: DesignConfig.aVeryHighBorderRadius,
                  ),
                  gradient: const LinearGradient(colors: [
                    Color(0xff4A4A4A),
                    Color(0xff575757),
                  ])),
              child: const HorizontalDashedLine(
                height: 2,
                active: Colors.white,
                dashed: true,
                dashSize: 10,
              ),
            ),
            Positioned(
                top: 6,
                left: 11.5,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: const Border(
                        bottom: BorderSide(color: Colors.white, width: 2),
                        left: BorderSide(color: Colors.white, width: 2),
                      )),
                )),
            Positioned(
                top: 6,
                right: 11.5,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: const Border(
                        bottom: BorderSide(color: Colors.white, width: 2),
                        right: BorderSide(color: Colors.white, width: 2),
                      )),
                ))
          ],
        ));
  }
}

enum DashedContainerAlign { none, top, left, bottom, right }

class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;
  final List<DashedContainerAlign>? dashedContainerAlign;

  const DashedRect(
      {super.key,
      this.color = Colors.black,
      this.strokeWidth = 1.0,
      this.gap = 5.0,
      this.dashedContainerAlign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(strokeWidth / 2),
      child: CustomPaint(
        painter: DashRectPainter(
            color: color,
            strokeWidth: strokeWidth,
            gap: gap,
            dashedContainerAlign: dashedContainerAlign),
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;
  final List<DashedContainerAlign>? dashedContainerAlign;

  DashRectPainter(
      {this.strokeWidth = 5.0,
      this.color = Colors.red,
      this.gap = 5.0,
      this.dashedContainerAlign});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path topPath = getDashedPath(
      a: const math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path leftPath = getDashedPath(
      a: const math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    if (dashedContainerAlign == null || dashedContainerAlign!.isEmpty) {
      canvas.drawPath(topPath, dashedPaint);
      canvas.drawPath(rightPath, dashedPaint);
      canvas.drawPath(bottomPath, dashedPaint);
      canvas.drawPath(leftPath, dashedPaint);
    } else {
      for (var element in dashedContainerAlign!) {
        if (element == DashedContainerAlign.top) {
          canvas.drawPath(topPath, dashedPaint);
        }
        if (element == DashedContainerAlign.bottom) {
          canvas.drawPath(bottomPath, dashedPaint);
        }
        if (element == DashedContainerAlign.left) {
          canvas.drawPath(leftPath, dashedPaint);
        }
        if (element == DashedContainerAlign.right) {
          canvas.drawPath(rightPath, dashedPaint);
        }
      }
    }
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
