import 'package:ajhman/core/cubit/audio/audio_player_cubit.dart';
import 'package:ajhman/core/cubit/audio/audio_player_cubit.dart';
import 'package:ajhman/core/services/audio_handler.dart';
import 'package:ajhman/data/model/audio_player_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../text/primary_text.dart';

class AudioBar extends StatefulWidget {
  final AudioHandler audioHandler;

  const AudioBar({super.key, required this.audioHandler});

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
                InkWell(
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
                  child: PrimaryText(
                      text: "${state.speed}X",
                      style: Theme.of(context).textTheme.navbarTitle,
                      color: Theme.of(context).progressText()),
                ),
                SizedBox(
                  width: 16,
                ),
                // Assets.icon.outline.download
                //     .svg(width: 24, height: 24, color: grayColor800),
                // SizedBox(
                //   width: 8,
                // ),
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
                      ? Assets.icon.outline.volumeHigh
                          .svg(width: 24, height: 24, color: Theme.of(context).pinTextFont())
                      : Assets.icon.outline.volumeSlash
                          .svg(width: 24, height: 24, color: Theme.of(context).pinTextFont()),
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
                  child: Assets.icon.outline.forward5Seconds
                      .svg(width: 24, height: 24, color: Theme.of(context).pinTextFont()),
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
                  child: Assets.icon.outline.backward5Seconds
                      .svg(width: 24, height: 24, color: Theme.of(context).pinTextFont()),
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
                      ? Assets.icon.outline.play
                          .svg(width: 24, height: 24, color: Theme.of(context).primaryColor)
                      : Assets.icon.outline.pause
                          .svg(width: 24, height: 24, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
