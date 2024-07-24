import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/design_config.dart';

class PrimaryImageNetwork extends StatelessWidget {
  final String src;
  final double aspectRatio;
  final BorderRadius radius;

  const PrimaryImageNetwork(
      {super.key,
      required this.src,
      required this.aspectRatio,
      this.radius = DesignConfig.highBorderRadius});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: ApiEndPoints.baseURL + src,
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Theme.of(context).white(),
                    )),
                errorWidget: (context, url, error) {
                  print("errr--------------------------------$error");
                  return Center(
                    child: Assets.image.moon.moon.image(),
                  );
                },
                fit: BoxFit.fill,
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
