import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../button/primary_button.dart';
import '../text/primary_text.dart';

class OnlineCard extends StatefulWidget {
  const OnlineCard({super.key});

  @override
  State<OnlineCard> createState() => _OnlineCardState();
}

class _OnlineCardState extends State<OnlineCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: DesignConfig.highBorderRadius,
          boxShadow: DesignConfig.lowShadow,
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image(),
              _title(),
              _info(),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: const PrimaryButton(title: "ورود به جلسه")),
            ],
          ),
        ),
      ),
    );
  }

  Padding _info( ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
            child: Assets.icon.outline.user.svg(width: 16, height: 16),
          ),
          PrimaryText(
              text: "دکتر کوروش شایگان",
              style: mThemeData.textTheme.searchHint,
              color: grayColor600)
        ],
      ),
    );
  }

  Padding _title( ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: PrimaryText(
          text: "مدیریت کسب و کار حرفه‌ای Post DBA",
          style: mThemeData.textTheme.titleBold,
          color: grayColor900),
    );
  }

  Stack _image() {
    return Stack(
      children: [
        const PrimaryImageNetwork(
            src:
                "https://s3-alpha-sig.figma.com/img/6bb2/c6e8/2ca30d2288e5dc2bd9b8c13c823e3fbe?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Fwarqfho~B3tM0YyitLfb70IYZBaYNhmWpNdahINDXsB-IX0eKF19uSJ3dwajJZWhNiNMIo1CpNFvX2w-YQVHpIHZXYYtrZ0L9shIjRBUUEVBjAmofbhdc-ShMoJzBZsv0M5gbpRkwWAIIjgAPfO4gO28e1CVdJyJBeZubk8RPeCqknaMNqDyT9SZFawUEU6de~F-wWp6L7WIz~z2-An8sarW5WpfvLyX6SFIbWxNWg7j4mY5Z9DgEfTaR-2QQxhnNwqplutSZxYipkD8nY8dahnlC1p3hdGHupw~ORsaBzOTnnfzzk7FkM0LL~V-1v~bnv6qmoDmaVzN6PeEwWxFA__",
            aspectRatio: 16 / 9),
        Positioned(
          right: 8,
          bottom: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: successBackground),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: successMain.withOpacity(0.3)),
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: successMain),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                PrimaryText(
                    text: "در حال برگزاری",
                    style: mThemeData.textTheme.searchHint,
                    color: successMain)
              ],
            ),
          ),
        )
      ],
    );
  }
}
