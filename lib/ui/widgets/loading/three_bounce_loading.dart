import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ThreeBounceLoading extends StatefulWidget{
  const ThreeBounceLoading({super.key});

  @override
  State<ThreeBounceLoading> createState() => _ThreeBounceLoadingState();
}

class _ThreeBounceLoadingState extends State<ThreeBounceLoading> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Colors.white,
      size: 50.0,
      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
    );
  }
}