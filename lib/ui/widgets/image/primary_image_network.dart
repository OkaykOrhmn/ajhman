import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/widget/design_config.dart';

class PrimaryImageNetwork extends StatelessWidget {
  final String src;
  final double aspectRatio;

  const PrimaryImageNetwork(
      {super.key, required this.src, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: DesignConfig.highBorderRadius,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl:
                    src,
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    )),
                errorWidget: (context, url, error) => Center(
                  child: Assets.image.moon.moon.image(),
                ),
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
                child: Container(
              color: const Color(0xff2672E7).withOpacity(0.16),
            )),
          ],
        ),
      ),
    );
  }
}
