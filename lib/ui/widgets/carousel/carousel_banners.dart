import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../main.dart';

class CarouseBanners extends StatefulWidget {
  final List<String> items;

  const CarouseBanners({super.key, required this.items});

  @override
  State<CarouseBanners> createState() => _CarouseBannersState();
}

class CustomCarouselController extends CarouselControllerImpl {
  CarouselState? _state;

  CarouselState? get state => _state;

  @override
  set state(CarouselState? state) {
    _state = state;
    super.state = state;
  }
}

class _CarouseBannersState extends State<CarouseBanners> {
  final CustomCarouselController _buttonCarouselController =
      CustomCarouselController();
  final CarouselOptions _carouselOptions = CarouselOptions(
    height: 160,
    aspectRatio: 16 / 9,
    viewportFraction: 1,
    initialPage: 0,
    disableCenter: true,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: true,
    enlargeFactor: 0.3,
    onPageChanged: (index, _) {},
    scrollDirection: Axis.horizontal,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          options: _carouselOptions,
          carouselController: _buttonCarouselController,
          itemCount: widget.items.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  _banner(context, itemIndex),
        ),
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: _bannerIndicator(),
        )
      ],
    );
  }

  FutureBuilder<Null> _bannerIndicator( ) {
    return FutureBuilder(
      future: _buttonCarouselController.onReady,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: DesignConfig.aHighBorderRadius,
                      topLeft: DesignConfig.aHighBorderRadius)),
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 0),
              child: SmoothPageIndicator(
                  controller: _buttonCarouselController.state!.pageController!,
                  count: widget.items.length,
                  effect: const ExpandingDotsEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      activeDotColor: Colors.black,
                      dotColor: Colors.white)),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Padding _banner(BuildContext context, int itemIndex) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 140,
        decoration: const BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: DesignConfig.highBorderRadius),
        child: const PrimaryImageNetwork(
            src:
                "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
            aspectRatio: 16 / 9),
      ),
    );
  }
}
