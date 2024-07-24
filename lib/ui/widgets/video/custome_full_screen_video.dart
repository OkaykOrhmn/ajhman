// ignore_for_file: deprecated_member_use, implementation_imports

import 'package:ajhman/core/cubit/video/video_player_cubit.dart';
import 'package:ajhman/core/services/video_handler.dart';
import 'package:flutter/material.dart';
import 'package:appinio_video_player/src/embedded_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CostumeFullscreenVideo extends StatelessWidget {
  final VideoHandler videoHandler;

  const CostumeFullscreenVideo({
    super.key,
    required this.videoHandler,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<VideoPlayerCubit>().changeFullScreen();
        await videoHandler.exitFullscreen();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: Stack(
            children: [
              EmbeddedVideoPlayer(
                customVideoPlayerController:
                    videoHandler.customVideoPlayerController,
                isFullscreen: true,
              ),
              // VideoBar(videoHandler: videoHandler)
            ],
          ),
        ),
      ),
    );
  }
}
