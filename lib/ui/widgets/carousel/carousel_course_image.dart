import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../gen/assets.gen.dart';
import '../../../main.dart';

class CarouseCourseImage extends StatefulWidget {
  final List<Media?> items;

  const CarouseCourseImage({super.key, required this.items});

  @override
  State<CarouseCourseImage> createState() => _CarouseBannersState();
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

class _CarouseBannersState extends State<CarouseCourseImage> {
  final CustomCarouselController _buttonCarouselController =
      CustomCarouselController();
  final CarouselOptions _carouselOptions = CarouselOptions(
    aspectRatio: 16 / 10,
    viewportFraction: 1,
    initialPage: 0,
    disableCenter: true,
    enableInfiniteScroll: false,
    reverse: false,
    autoPlay: false,
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
        Positioned.fill(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (_buttonCarouselController._state!.pageController!.page!
                          .toInt() ==
                      0) {
                    return;
                  }
                  _buttonCarouselController.animateToPage(
                      _buttonCarouselController._state!.pageController!.page!
                              .toInt() -
                          1,
                      duration: Duration(milliseconds: 800));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4)
                      .copyWith(right: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).white().withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: DesignConfig.aHighBorderRadius,
                        bottomLeft: DesignConfig.aHighBorderRadius),
                  ),
                  child: Assets.icon.outline.arrowLeft
                      .svg(width: 16, height: 16, color: Theme.of(context).headText()),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_buttonCarouselController._state!.pageController!.page!
                          .toInt() ==
                      widget.items.length - 1) {
                    return;
                  }
                  _buttonCarouselController.animateToPage(
                      _buttonCarouselController._state!.pageController!.page!
                              .toInt() +
                          1,
                      duration: Duration(milliseconds: 800));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4)
                      .copyWith(left: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).white().withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        bottomRight: DesignConfig.aHighBorderRadius,
                        topRight: DesignConfig.aHighBorderRadius),
                  ),
                  child: Assets.icon.outline.arrowRight1
                      .svg(width: 16, height: 16, color: Theme.of(context).headText()),
                ),
              ),
            ],
          ),
        )),
        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: _bannerIndicator(),
        )
      ],
    );
  }

  FutureBuilder<Null> _bannerIndicator() {
    return FutureBuilder(
      future: _buttonCarouselController.onReady,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: SmoothPageIndicator(
                controller: _buttonCarouselController.state!.pageController!,
                count: widget.items.length,
                effect:  ExpandingDotsEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Colors.white)),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Padding _banner(BuildContext context, int itemIndex) {
    print( widget.items[itemIndex]!.source);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: DesignConfig.highBorderRadius),
        child:  PrimaryImageNetwork(
            // src: "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
            src: widget.items[itemIndex]!.source.toString(),
            aspectRatio: 16 / 10),
      ),
    );
  }
}
