import 'package:ajhman/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/design_config.dart';

class DefaultPlaceHolder extends StatelessWidget {
  final Widget child;

  const DefaultPlaceHolder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).placeholderBaseColor(),
      highlightColor: Theme.of(context).placeholderHighlightColor(),
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).white(),
              borderRadius: DesignConfig.highBorderRadius),
          child: child),
    );
  }
}
