import 'package:ajhman/core/cubit/audio/audio_player_cubit.dart';
import 'package:ajhman/core/cubit/audio/audio_player_cubit.dart';
import 'package:ajhman/core/services/audio_handler.dart';
import 'package:ajhman/data/model/audio_player_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/progress/circle_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../../core/cubit/download/download_cubit.dart';
import '../../../core/enum/dialogs_status.dart';
import '../../../data/api/api_end_points.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../snackbar/snackbar_handler.dart';
import '../text/primary_text.dart';

class AudioBar extends StatefulWidget {
  final AudioHandler audioHandler;
  final String audioSource;
  final String name;

  const AudioBar(
      {super.key,
      required this.audioHandler,
      required this.audioSource,
      required this.name});

  @override
  State<AudioBar> createState() => _AudioBarState();
}

class _AudioBarState extends State<AudioBar> {
  @override
  Widget build(BuildContext context) {
    final audioHandler = widget.audioHandler;

    return BlocBuilder<AudioPlayerCubit, AudioPlayerModel>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 48,
                  child: InkWell(
                    onTap: () {
                      if (state.speed == 2.0) {
                        context.read<AudioPlayerCubit>().changeSpeed(0.5);
                      } else {
                        context
                            .read<AudioPlayerCubit>()
                            .changeSpeed(state.speed += 0.25);
                      }
                      audioHandler.player.setPlaybackRate(
                          context.read<AudioPlayerCubit>().state.speed);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: PrimaryText(
                          text: "${state.speed}X",
                          style: Theme.of(context).textTheme.navbarTitleBold,
                          color: Theme.of(context).progressText()),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await context.read<DownloadCubit>().downloadAudio(
                        ApiEndPoints.baseURL + widget.audioSource,
                        widget.name);
                  },
                  child: BlocConsumer<DownloadCubit, DownloadState>(
                    listener: (context, state) {
                      if (state is DownloadFail) {
                        SnackBarHandler(context)
                            .show(state.error, DialogStatus.error, false);
                      } else if (state is DownloadSuccess) {
                        SnackBarHandler(context).show("با موفقیت دانلود شد 😃",
                            DialogStatus.success, true);
                      } else if (state is DownloadedAlready) {
                        SnackBarHandler(context)
                            .show("فایل موجود است 🧐", DialogStatus.info, true);
                      }
                    },
                    builder: (context, state) {
                      if (state is DownloadLoading) {
                        return CircleProgress(
                          value: (state.pr / 100),
                          strokeWidth: 2,
                          width: 24,
                          height: 24,
                          text: "${state.pr}",
                        );
                      } else {
                        return Assets.icon.outline.download
                            .svg(width: 24, height: 24, color: grayColor800);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () async {
                    double volume = await VolumeController().getVolume();
                    if (state.volume == 0) {
                      context.read<AudioPlayerCubit>().setVolume(volume);
                    } else {
                      context.read<AudioPlayerCubit>().setVolume(0);
                    }
                    await audioHandler.player.setVolume(
                        context.read<AudioPlayerCubit>().state.volume);
                  },
                  child: state.volume != 0
                      ? Assets.icon.outline.volumeHigh.svg(
                          width: 24,
                          height: 24,
                          color: Theme.of(context).pinTextFont())
                      : Assets.icon.outline.volumeSlash.svg(
                          width: 24,
                          height: 24,
                          color: Theme.of(context).pinTextFont()),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (audioHandler.audioPosition!.inSeconds <
                        audioHandler.audioDuration!.inSeconds - 5) {
                      final p = Duration(
                          seconds: audioHandler.audioPosition!.inSeconds + 5);
                      audioHandler.player.seek(p);
                    }
                  },
                  child: Assets.icon.outline.forward5Seconds.svg(
                      width: 24,
                      height: 24,
                      color: Theme.of(context).pinTextFont()),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    if (audioHandler.audioPosition!.inSeconds > 5) {
                      final p = Duration(
                          seconds: audioHandler.audioPosition!.inSeconds - 5);
                      audioHandler.player.seek(p);
                    }
                  },
                  child: Assets.icon.outline.backward5Seconds.svg(
                      width: 24,
                      height: 24,
                      color: Theme.of(context).pinTextFont()),
                ),
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {
                    context.read<AudioPlayerCubit>().changePause();
                    if (state.pause) {
                      audioHandler.play();
                    } else {
                      audioHandler.pause();
                    }
                  },
                  child: state.pause
                      ? Assets.icon.outline.play.svg(
                          width: 24,
                          height: 24,
                          color: Theme.of(context).primaryColor)
                      : Assets.icon.outline.pause.svg(
                          width: 24,
                          height: 24,
                          color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
