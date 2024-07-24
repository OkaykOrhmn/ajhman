///
/// author: Mahen Gandhi <mahengandhi19@gmail.com>
/// github: https://github.com/imlegend19
///

// ignore_for_file: library_private_types_in_public_api

library skeleton_text;

import 'package:flutter/material.dart';

class SkeletonAnimation extends StatefulWidget {
  final Widget child;
  final Color shimmerColor;
  final Color gradientColor;
  final Curve curve;
  final BorderRadiusGeometry borderRadius;
  final int shimmerDuration;

  const SkeletonAnimation({
    required this.child,
    this.shimmerColor = Colors.white54,
    this.gradientColor = const Color.fromARGB(0, 244, 244, 244),
    this.curve = Curves.fastOutSlowIn,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.shimmerDuration = 1000,
    super.key,
  });

  @override
  _SkeletonAnimationState createState() => _SkeletonAnimationState();
}

class _SkeletonAnimationState extends State<SkeletonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.shimmerDuration),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  E? firstOrNull<E>(Iterable<DiagnosticsNode> list) =>
      list.isEmpty ? null : list.first.value as E?;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Positioned.fill(
          child: Container(
            color: Colors.transparent,
            margin: firstOrNull(widget.child
                .toDiagnosticsNode()
                .getProperties()
                .where((element) => element.name == "margin")),
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return FractionallySizedBox(
                    widthFactor: .2,
                    alignment: AlignmentGeometryTween(
                      begin: const Alignment(-1.0 - .2 * 3, .0),
                      end: const Alignment(1.0 + .2 * 3, .0),
                    )
                        .chain(CurveTween(curve: widget.curve))
                        .evaluate(_controller)!,
                    child: child,
                  );
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.gradientColor,
                        widget.shimmerColor,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
