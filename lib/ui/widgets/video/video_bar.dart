import 'package:ajhman/data/model/video_player_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../../core/cubit/download/download_cubit.dart';
import '../../../core/cubit/video/video_player_cubit.dart';
import '../../../core/enum/dialogs_status.dart';
import '../../../core/services/video_handler.dart';
import '../../../data/api/api_end_points.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../animation/animated_visibility.dart';
import '../progress/circle_progress.dart';
import '../snackbar/snackbar_handler.dart';
import '../text/primary_text.dart';

class VideoBar extends StatefulWidget {
  final VideoHandler videoHandler;
  final String audioSource;
  final List<String> name;

  const VideoBar(
      {super.key,
      required this.videoHandler,
      required this.audioSource,
      required this.name});

  @override
  State<VideoBar> createState() => _VideoBarState();
}

class _VideoBarState extends State<VideoBar> {
  @override
  Widget build(BuildContext context) {
    final videoHandler = widget.videoHandler;
    return Positioned(
      bottom: 12,
      left: 12,
      right: 12,
      child: BlocBuilder<VideoPlayerCubit, VideoPlayerModel>(
        builder: (context, state) {
          return AnimatedVisibility(
            isVisible: state.showControls,
            duration: const Duration(milliseconds: 400),
            fadeMode: FadeMode.none,
            curve: Curves.easeOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        context.read<VideoPlayerCubit>().changeFullScreen();
                        if (state.fullScreen) {
                          await videoHandler.exitFullscreen();
                        } else {
                          await videoHandler.enterFullscreen();
                        }
                      },
                      child: Assets.icon.outline.maximize3
                          .svg(width: 24, height: 24, color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        await context.read<DownloadCubit>().downloadAudio(
                             widget.audioSource,
                            widget.name,"ویدیو");
                      },
                      child: BlocConsumer<DownloadCubit, DownloadState>(
                        listener: (downloadContext, state) {
                          if (state is DownloadFail) {
                            SnackBarHandler(context)
                                .show(state.error, DialogStatus.error, false);
                          } else if (state is DownloadSuccess) {
                            SnackBarHandler(context).show(
                                "با موفقیت دانلود شد 😃",
                                DialogStatus.success,
                                true);
                          } else if (state is DownloadedAlready) {
                            SnackBarHandler(context).show(
                                "فایل موجود است 🧐", DialogStatus.info, true);
                          }
                        },
                        builder: (context, state) {
                          if (state is DownloadLoading) {
                            return CircleProgress(
                              value: (state.pr / 100),
                              strokeWidth: 2,
                              width: 24,
                              height: 24,
                              backgroundColor: Colors.white,
                              text: "${state.pr}",
                            );
                          } else {
                            return Assets.icon.outline.download.svg(
                                width: 24, height: 24, color: Colors.white);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        if (state.speed == 2.0) {
                          context.read<VideoPlayerCubit>().changeSpeed(0.5);
                        } else {
                          context
                              .read<VideoPlayerCubit>()
                              .changeSpeed(state.speed += 0.25);
                        }
                        videoHandler
                            .customVideoPlayerController.videoPlayerController
                            .setPlaybackSpeed(
                                context.read<VideoPlayerCubit>().state.speed);
                        print(
                            "${videoHandler.customVideoPlayerController.videoPlayerController.value.playbackSpeed}--------------");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6)),
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: Center(
                          child: PrimaryText(
                              text: "${state.speed}X",
                              style: mThemeData.textTheme.navbarTitle,
                              color: grayColor800),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        context.read<VideoPlayerCubit>().changeMute();
                        double volume = await VolumeController().getVolume();

                        if (state.mute) {
                          videoHandler
                              .customVideoPlayerController.videoPlayerController
                              .setVolume(volume);
                        } else {
                          videoHandler
                              .customVideoPlayerController.videoPlayerController
                              .setVolume(0);
                        }
                      },
                      child: state.mute
                          ? Assets.icon.outline.volumeSlash
                              .svg(width: 24, height: 24, color: Colors.white)
                          : Assets.icon.outline.volumeHigh
                              .svg(width: 24, height: 24, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Duration? pos = await videoHandler
                            .customVideoPlayerController
                            .videoPlayerController
                            .position;
                        if (pos != null) {
                          Duration next = Duration(seconds: pos.inSeconds + 5);
                          videoHandler
                              .customVideoPlayerController.videoPlayerController
                              .seekTo(next);
                        }
                      },
                      child: Assets.icon.outline.forward5Seconds
                          .svg(width: 24, height: 24, color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        Duration? pos = await videoHandler
                            .customVideoPlayerController
                            .videoPlayerController
                            .position;
                        if (pos != null) {
                          Duration next = Duration(seconds: pos.inSeconds - 5);
                          videoHandler
                              .customVideoPlayerController.videoPlayerController
                              .seekTo(next);
                        }
                      },
                      child: Assets.icon.outline.backward5Seconds
                          .svg(width: 24, height: 24, color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<VideoPlayerCubit>().changePause();
                        if (state.pause) {
                          videoHandler
                              .customVideoPlayerController.videoPlayerController
                              .play();
                        } else {
                          videoHandler
                              .customVideoPlayerController.videoPlayerController
                              .pause();
                        }
                      },
                      child: state.pause
                          ? Assets.icon.outline.play
                              .svg(width: 24, height: 24, color: Colors.white)
                          : Assets.icon.outline.pause
                              .svg(width: 24, height: 24, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
