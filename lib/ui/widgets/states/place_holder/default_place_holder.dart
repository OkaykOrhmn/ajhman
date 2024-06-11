import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/widget/design_config.dart';

class DefaultPlaceHolder extends StatelessWidget {
  final Widget child;

  const DefaultPlaceHolder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: DesignConfig.highBorderRadius),
          child: child),
    );
  }
}
