import 'dart:math';

import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/core/services/audio_handler.dart';
import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/audio/audio_bar.dart';
import 'package:ajhman/ui/widgets/carousel/carousel_course_image.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/bloc/chapter/chapter_bloc.dart';
import '../../../../../core/cubit/audio/audio_player_cubit.dart';
import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../widgets/loading/three_bounce_loading.dart';

class CourseAudio extends StatefulWidget {
  const CourseAudio({super.key});

  @override
  State<CourseAudio> createState() => _CourseAudioState();
}

class _CourseAudioState extends State<CourseAudio> {
  List<AudioWaveBar> bars = [];
  int size = 100;
  late AudioHandler audioHandler;
  late Duration? duration;
  late Duration? position;
  PlayerState? playerState = null;
  late ChapterModel data;
  late Media banner;
  late Media audio;

  @override
  void initState() {
    data = context.read<SubChapterCubit>().state!.chapterModel;
    for (var element in data.media!) {
      if (element.type == CourseTypes.image.type) {
        banner = element;
      }
      if (element.type == CourseTypes.audio.type) {
        audio = element;
      }
    }

    audioHandler = AudioHandler(audio.source.toString());
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
      audioHandler.durationSubscriptionS?.cancel();
      audioHandler.positionSubscriptionS?.cancel();
      audioHandler.playerCompleteSubscriptionS?.cancel();
      audioHandler.playerStateChangeSubscriptionS?.cancel();
      if (audioHandler.isPlaying) {
        audioHandler.stop();
      }
      context.read<AudioPlayerCubit>().reset();
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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PrimaryImageNetwork(
              // src:
              // "https://www.figma.com/file/Qe9pcE7Ts9ZtdwPvUUlBmA/image/ff1d273ecaa678018bbc0b2e8ad787cda708a713",
              src: banner.source.toString(),
              aspectRatio: 16 / 9),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.lowShadow,
                color: Theme.of(context).cardBackground()),
            child: Stack(
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
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.transparent),
                                  onChanged: (value) {
                                    setState(() {
                                      if (duration == null) {
                                        return;
                                      }

                                      final position =
                                          value * duration!.inMilliseconds;
                                      audioHandler.player.seek(Duration(
                                          milliseconds: position.round()));

                                      var a = (position * size) /
                                          duration!.inMilliseconds;
                                      for (int i = 0; i <= size; i++) {
                                        if (i <= a) {
                                          bars[i].color = Theme.of(context).primaryColor;
                                        } else {
                                          bars[i].color = Theme.of(context).placeholderBaseColor();
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
                      SizedBox(
                        height: 16,
                      ),
                      AudioBar(
                        audioHandler: audioHandler,
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
                        child: ThreeBounceLoading(),
                      ))
                    : SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
