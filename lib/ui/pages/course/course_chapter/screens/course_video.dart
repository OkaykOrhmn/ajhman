import 'package:ajhman/data/model/video_player_model.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/video/video_bar.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';
import '../../../../../core/cubit/video/video_player_cubit.dart';
import '../../../../../core/services/video_handler.dart';
import '../../../../../data/model/chapter_model.dart';

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
    data = context.read<SubChapterCubit>().state.chapterModel;
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
    videoHandler.customVideoPlayerController.dispose();
    if (videoHandler
        .customVideoPlayerController.videoPlayerController.value.isPlaying) {
      videoHandler.customVideoPlayerController.videoPlayerController.pause();
      videoHandler.customVideoPlayerController.videoPlayerController.dispose();
    }
    context.read<VideoPlayerCubit>().reset();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerModel>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: DesignConfig.highBorderRadius,
                  child: loading
                      ? Shimmer.fromColors(
                          baseColor: Theme.of(context).placeholderBaseColor(),
                          highlightColor:
                              Theme.of(context).placeholderHighlightColor(),
                          child: Container(
                            color: Colors.white,
                          ))
                      : CustomVideoPlayer(
                          customVideoPlayerController:
                              videoHandler.customVideoPlayerController,
                        ),
                ),
              ),
              VideoBar(
                videoHandler: videoHandler,
                audioSource: video.source.toString(),
                name: [
                  context
                      .read<SubChapterCubit>()
                      .state
                      .courseData
                      .name
                      .toString(),
                  data.name.toString()
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
