import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ThreeBounceLoading extends StatefulWidget {
  final double size;
  const ThreeBounceLoading({super.key,  this.size = 50});

  @override
  State<ThreeBounceLoading> createState() => _ThreeBounceLoadingState();
}

class _ThreeBounceLoadingState extends State<ThreeBounceLoading>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: Theme.of(context).primaryColor,
        size: widget.size,
        controller: _controller,
      ),
    );
  }
}
