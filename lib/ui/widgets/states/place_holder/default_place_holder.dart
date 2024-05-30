import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultPlaceHolder extends StatelessWidget {
  final bool isLoading;
  final dynamic widget;

  const DefaultPlaceHolder({super.key, this.isLoading = false, required this.widget});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: widget,
          )
        : widget;
  }
}
