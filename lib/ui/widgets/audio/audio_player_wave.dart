import 'dart:math';

import 'package:audio_wave/audio_wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/audio/audio_player_cubit.dart';
import '../../../core/services/audio_handler.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../loading/three_bounce_loading.dart';
import 'audio_bar.dart';

class AudioPlayerWave extends StatefulWidget {
  final String source;
  final List<String> name;

  const AudioPlayerWave({super.key, required this.source, required this.name});

  @override
  State<AudioPlayerWave> createState() => _AudioPlayerWaveState();
}

class _AudioPlayerWaveState extends State<AudioPlayerWave> {
  List<AudioWaveBar> bars = [];
  int size = 100;
  late AudioHandler audioHandler;
  late Duration? duration;
  late Duration? position;
  PlayerState? playerState;

  @override
  void initState() {
    audioHandler = AudioHandler(widget.source.toString());
    duration = audioHandler.audioDuration;
    position = audioHandler.audioPosition;
    _initStreams();

    bars.clear();
    for (int i = 0; i <= size; i++) {
      Random random = Random();
      double randomNumber1 = random.nextDouble();
      bars.add(
        AudioWaveBar(
            heightFactor: randomNumber1, color: grayColor300, radius: 16),
      );
    }

    super.initState();
  }

  void _initStreams() {
    audioHandler.durationSubscription((d) => setState(() => duration = d));
    audioHandler.positionSubscription((p) => setState(() => position = p));
    audioHandler.playerCompleteSubscription(
        () => context.read<AudioPlayerCubit>().setPause(true));
    audioHandler.playerStateChangeSubscription((p0) => setState(() {
          playerState = p0;
        }));
  }

  @override
  void dispose() {
    if (playerState != null) {
      if (audioHandler.isPlaying) {
        audioHandler.stop();
      }
      context.read<AudioPlayerCubit>().reset();
      audioHandler.durationSubscriptionS?.cancel();
      audioHandler.positionSubscriptionS?.cancel();
      audioHandler.playerCompleteSubscriptionS?.cancel();
      audioHandler.playerStateChangeSubscriptionS?.cancel();

    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i <= size; i++) {
      final a = (position!.inMilliseconds * 100) / duration!.inMilliseconds;
      if (i <= a) {
        bars[i].color = Theme.of(context).primaryColor;
      } else {
        bars[i].color = grayColor300;
      }
    }
    return Stack(
      children: [
        IgnorePointer(
          ignoring: playerState == null,
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Stack(
                  children: [
                    AudioWave(
                      height: 60,
                      width: MediaQuery.sizeOf(context).width - 64,
                      spacing: 2.5,
                      beatRate: Duration.zero,
                      animationLoop: 0,
                      bars: bars,
                      animation: false,
                    ),
                    Positioned.fill(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          thumbShape: RoundSliderThumbShape(
                              elevation: 0,
                              disabledThumbRadius: 0,
                              enabledThumbRadius: 0,
                              pressedElevation: 0),
                          overlayColor: Colors.transparent,
                        ),
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          activeColor: Colors.transparent,
                          secondaryActiveColor: Colors.transparent,
                          thumbColor: Colors.transparent,
                          overlayColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.transparent),
                          onChanged: (value) {
                            setState(() {
                              if (duration == null) {
                                return;
                              }

                              final position = value * duration!.inMilliseconds;
                              audioHandler.player.seek(
                                  Duration(milliseconds: position.round()));

                              var a =
                                  (position * size) / duration!.inMilliseconds;
                              for (int i = 0; i <= size; i++) {
                                if (i <= a) {
                                  bars[i].color =
                                      Theme.of(context).primaryColor;
                                } else {
                                  bars[i].color =
                                      Theme.of(context).placeholderBaseColor();
                                }
                              }
                            });
                          },
                          value: (position != null &&
                                  duration != null &&
                                  position!.inMilliseconds > 0 &&
                                  position!.inMilliseconds <
                                      duration!.inMilliseconds)
                              ? position!.inMilliseconds /
                                  duration!.inMilliseconds
                              : 0.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              AudioBar(
                audioHandler: audioHandler,
                audioSource: widget.source,
                name: widget.name,
              )
            ],
          ),
        ),
        playerState == null
            ? Positioned.fill(
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: DesignConfig.highBorderRadius,
                  color: Theme.of(context).white().withOpacity(0.5),
                ),
                child: const ThreeBounceLoading(),
              ))
            : const SizedBox(),
      ],
    );
  }
}
