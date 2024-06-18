import 'package:ajhman/data/model/video_player_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/animation/animated_visibility.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/video/custome_full_screen_video.dart';
import 'package:ajhman/ui/widgets/video/video_bar.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/src/fullscreen_video_player.dart';

import '../../../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';
import '../../../../../core/cubit/video/video_player_cubit.dart';
import '../../../../../core/services/video_handler.dart';
import '../../../../../data/model/chapter_model.dart';
import '../../../../../gen/assets.gen.dart';

class CourseVideo extends StatefulWidget {
  const CourseVideo({super.key});

  @override
  State<CourseVideo> createState() => _CourseVideoState();
}

class _CourseVideoState extends State<CourseVideo> {
  bool loading = true;
  late VideoHandler videoHandler;
  late ChapterModel data;
  late Media video;

  void _whenInitialize() {
    final read = context.read<VideoPlayerCubit>();
    loading = false;
    read.setShowControls(true);
  }

  @override
  void initState() {
    super.initState();
    final data = context.read<SubChapterCubit>().state!.chapterModel;
    video = data.media![0];

    videoHandler =
        VideoHandler(context, video.source.toString(), _whenInitialize);

    videoHandler.customVideoPlayerController.videoPlayerController
        .addListener(() {
      final read = context.read<VideoPlayerCubit>();

      if (!videoHandler.customVideoPlayerController.videoPlayerController.value
              .isPlaying &&
          videoHandler.customVideoPlayerController.videoPlayerController.value
              .isInitialized &&
          (videoHandler.customVideoPlayerController.videoPlayerController.value
                  .duration ==
              videoHandler.customVideoPlayerController.videoPlayerController
                  .value.position)) {
        //checking the duration and position every time
        read.setPause(true);
        videoHandler.customVideoPlayerController.videoPlayerController
            .seekTo(Duration.zero);
        if (read.state.pause) {
          videoHandler.customVideoPlayerController.videoPlayerController.play();
        } else {
          videoHandler.customVideoPlayerController.videoPlayerController
              .pause();
        }
      }
    });

    videoHandler.customVideoPlayerController.areControlsVisible.addListener(() {
      setState(() {
        final read = context.read<VideoPlayerCubit>();
        read.setShowControls(
            videoHandler.customVideoPlayerController.areControlsVisible.value);
      });
    });
  }

  @override
  void dispose() {
    print("hi");
    if (videoHandler != null) {
      videoHandler.customVideoPlayerController.dispose();
      if (videoHandler
          .customVideoPlayerController.videoPlayerController.value.isPlaying) {
        videoHandler.customVideoPlayerController.videoPlayerController.pause();
        videoHandler.customVideoPlayerController.videoPlayerController
            .dispose();
      }
      context.read<VideoPlayerCubit>().reset();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerModel>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: DesignConfig.highBorderRadius,
                  child: loading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ))
                      : CustomVideoPlayer(
                          customVideoPlayerController:
                              videoHandler.customVideoPlayerController,
                        ),
                ),
              ),
              VideoBar(videoHandler: videoHandler)
            ],
          ),
        );
      },
    );
  }
}
