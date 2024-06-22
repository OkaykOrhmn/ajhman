import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/widget/design_config.dart';

class ProfileImageNetwork extends StatelessWidget {
  final String src;
  final double width;
  final double height;

  const ProfileImageNetwork(
      {super.key,
      required this.src,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipRRect(
          borderRadius: DesignConfig.circularBorderRadius,
          child: CachedNetworkImage(
            imageUrl: src,
            placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                )),
            errorWidget: (context, url, error) =>
                Theme.of(context).brightness == Brightness.light
                    ? Assets.icon.profilePlaceholder
                        .svg(width: width, height: height)
                    : Assets.icon.profilePlaceholderDark
                        .svg(width: width, height: height),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
