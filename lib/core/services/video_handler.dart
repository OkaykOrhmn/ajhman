// ignore_for_file: deprecated_member_use

import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/main.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui/theme/colors.dart';
import '../../ui/widgets/video/custome_full_screen_video.dart';

String longVideo =
    "https://trailer.uptvs.com/trailer/Despicable-Me-4-Trailer.mp4";

class VideoHandler {
  CustomVideoPlayerController get customVideoPlayerController =>
      _customVideoPlayerController;

  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  VideoHandler(BuildContext context, String url, Function() whenInitialize) {
    _videoPlayerController = VideoPlayerController.network(
      ApiEndPoints.baseURL + url,
    )..initialize().then((value) => whenInitialize());
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        showSeekButtons: false,
        playbackSpeedButtonAvailable: false,
        showDurationPlayed: false,
        showDurationRemaining: false,
        showFullscreenButton: false,
        showPlayButton: false,
        controlBarPadding: const EdgeInsets.only(bottom: 40),
        settingsButtonAvailable: false,
        seekDuration: const Duration(seconds: 5),
        customVideoPlayerProgressBarSettings:
            CustomVideoPlayerProgressBarSettings(
                backgroundColor:
                    Theme.of(navigatorKey.currentContext!).primaryColor50(),
                bufferedColor:
                    Theme.of(navigatorKey.currentContext!).primaryColor100(),
                progressColor:
                    Theme.of(navigatorKey.currentContext!).primaryColor),
        controlBarDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      // additionalVideoSources: {
      //   "240p": _videoPlayerController2,
      //   "480p": _videoPlayerController3,
      //   "720p": _videoPlayerController,
      // },
    );
  }

  Future<void> enterFullscreen() async {
    final TransitionRoute<void> route = PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return CostumeFullscreenVideo(
              videoHandler: this,
            );
          },
        );
      },
    );
    _setOrientationForVideo();
    await navigatorKey.currentState!.push(route);
  }

  Future<void> exitFullscreen() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(
      customVideoPlayerController
          .customVideoPlayerSettings.systemUIModeAfterFullscreen,
      overlays: customVideoPlayerController
          .customVideoPlayerSettings.systemUIOverlaysAfterFullscreen,
    );
    await SystemChrome.setPreferredOrientations(customVideoPlayerController
        .customVideoPlayerSettings
        .deviceOrientationsAfterFullscreen); // reset device orientation values
    navigatorKey.currentState!.pop();
  }

  void _setOrientationForVideo() {
    final double videoWidth =
        _customVideoPlayerController.videoPlayerController.value.size.width;
    final double videoHeight =
        _customVideoPlayerController.videoPlayerController.value.size.height;
    final bool isLandscapeVideo = videoWidth > videoHeight;
    final bool isPortraitVideo = videoWidth < videoHeight;

    if (isLandscapeVideo) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else if (isPortraitVideo) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }
}
