import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/divider/vertical_dashed_line.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'divider/horizontal_dashed_line.dart';

class Road extends StatefulWidget {
  final int index;
  final int length;
  final double? height;

  const Road({super.key, required this.index, required this.length, this.height});

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
      child: Container(
        width: 80,
        height: widget.height?? 100,
        child: Stack(
          children: [
            top(),
            isEven ? left() : right(),
            // Positioned(
            //     left: 12,
            //     right: 18,
            //     bottom: 0,
            //     top: 18,
            //     child: DottedBorder(
            //       strokeWidth: 2,
            //       color: Colors.white,
            //       borderType: BorderType.RRect,
            //       radius: Radius.circular(10),
            //       dashPattern: [5, 5],
            //       child: Container(
            //         width: 200,
            //         height: 100,
            //         color: Colors.transparent,
            //       ),
            //     )),

            // bottom(),
          ],
        ),
      ),
    );
  }

  // Positioned bottom() {
  //   return Positioned(
  //       right: 0,
  //       bottom: 0,
  //       left: 0,
  //       child: Container(
  //         height: 40,
  //         decoration: BoxDecoration(
  //             borderRadius: DesignConfig.veryHighBorderRadius,
  //             gradient: LinearGradient(colors: [
  //               Color(0xff4A4A4A),
  //               Color(0xff575757),
  //             ])),
  //       ));
  // }

  Positioned right() {
    return Positioned(
        right: 0,
        bottom: 0,
        top: 0,
        child: Container(
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
                topRight: isEven? Radius.zero:DesignConfig.aVeryHighBorderRadius,
                topLeft: isEven? DesignConfig.aVeryHighBorderRadius:Radius.zero,
              ),
              gradient: LinearGradient(colors: [
                Color(0xff4A4A4A),
                Color(0xff575757),
              ])),
          // child: VerticalDashedLine(width: 2,active: Colors.white, dashed: true),

        ));
  }

  Positioned left() {
    return Positioned(
        left: 0,
        bottom: 0,
        top: 0,
        child: Container(
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.zero,
                topLeft: DesignConfig.aVeryHighBorderRadius,
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero
              ),
              gradient: LinearGradient(colors: [
                Color(0xff4A4A4A),
                Color(0xff575757),
              ])),
          // child: VerticalDashedLine(width: 2,active: Colors.white, dashed: true),

        ));
  }

  Positioned top() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Container(
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight:
                    isEven ? Radius.zero : DesignConfig.aVeryHighBorderRadius,
                topLeft:   isEven
                    ? DesignConfig.aVeryHighBorderRadius
                    : Radius.zero,
                bottomLeft: DesignConfig.aVeryHighBorderRadius,
                bottomRight: DesignConfig.aVeryHighBorderRadius,
              ),
              gradient: LinearGradient(colors: [
                Color(0xff4A4A4A),
                Color(0xff575757),
              ])),
          // child: HorizontalDashedLine(height: 2,active: true, dashed: true),
        ));
  }

  Widget _roadLine() {
    final double size = 24;
    final border =
        BorderSide(width: size, color: Colors.black, style: BorderStyle.solid);
    final top = BorderSide(
        width: widget.index != 1 ? size / 2 : size,
        color: Colors.black,
        style: BorderStyle.solid);
    final bottom = BorderSide(
        width: widget.index != 5 ? size / 2 : size,
        color: Colors.black,
        style: BorderStyle.solid);
    return Center(
      child: Stack(
        children: [
          Container(
            width: 70,
            height: 120,
            decoration: BoxDecoration(
              border: Border(
                top: top,
                bottom: bottom,
                right: isEven ? BorderSide.none : border,
                left: isEven ? border : BorderSide.none,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: size / 3,
            right: size / 3,
            bottom: 0,
            child: DashedRect(
              color: Colors.red,
              strokeWidth: 2.0,
              gap: 8.0,
              dashedContainerAlign: [
                isEven ? DashedContainerAlign.left : DashedContainerAlign.right,
              ],
            ),
          ),
          Positioned(
            top: size / 3,
            left: 0,
            right: 0,
            bottom: size / 3,
            child: DashedRect(
              color: Colors.red,
              strokeWidth: 2.0,
              gap: 8.0,
              dashedContainerAlign: [
                widget.index == 1
                    ? DashedContainerAlign.top
                    : DashedContainerAlign.none,
                widget.index == 5
                    ? DashedContainerAlign.bottom
                    : DashedContainerAlign.none,
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: DashedRect(
              color: Colors.red,
              strokeWidth: 2.0,
              gap: 8.0,
              dashedContainerAlign: [
                widget.index != 5
                    ? DashedContainerAlign.bottom
                    : DashedContainerAlign.none,
              ],
            ),
          ),
        ],
      ),
    );
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
    return Container(
      child: Padding(
        padding: EdgeInsets.all(strokeWidth / 2),
        child: CustomPaint(
          painter: DashRectPainter(
              color: color,
              strokeWidth: strokeWidth,
              gap: gap,
              dashedContainerAlign: dashedContainerAlign),
        ),
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

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    if (dashedContainerAlign == null || dashedContainerAlign!.isEmpty) {
      canvas.drawPath(_topPath, dashedPaint);
      canvas.drawPath(_rightPath, dashedPaint);
      canvas.drawPath(_bottomPath, dashedPaint);
      canvas.drawPath(_leftPath, dashedPaint);
    } else {
      for (var element in dashedContainerAlign!) {
        if (element == DashedContainerAlign.top) {
          canvas.drawPath(_topPath, dashedPaint);
        }
        if (element == DashedContainerAlign.bottom) {
          canvas.drawPath(_bottomPath, dashedPaint);
        }
        if (element == DashedContainerAlign.left) {
          canvas.drawPath(_leftPath, dashedPaint);
        }
        if (element == DashedContainerAlign.right) {
          canvas.drawPath(_rightPath, dashedPaint);
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
