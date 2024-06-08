import 'dart:math';

import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/carousel/carousel_course_image.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';

class CourseAudio extends StatefulWidget {
  const CourseAudio({super.key});

  @override
  State<CourseAudio> createState() => _CourseAudioState();
}

class _CourseAudioState extends State<CourseAudio> {

  List<AudioWaveBar> bars = [];


  @override
  Widget build(BuildContext context) {
    bars.clear();
    for (int i = 0; i <= 100; i++) {
      Random random = Random();
      double randomNumber1 = random.nextDouble();
      bars.add(
        AudioWaveBar(
            heightFactor: randomNumber1,
            color: i>60? primaryColor:grayColor300,
            radius: 16),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PrimaryImageNetwork(
              src:
                  "https://www.figma.com/file/Qe9pcE7Ts9ZtdwPvUUlBmA/image/ff1d273ecaa678018bbc0b2e8ad787cda708a713",
              aspectRatio: 16 / 9),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.lowShadow,
                color: backgroundColor100),
            child: Column(
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
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        PrimaryText(
                            text: "1X",
                            style: mThemeData.textTheme.navbarTitle,
                            color: grayColor900),
                        SizedBox(
                          width: 16,
                        ),
                        Assets.icon.outline.download
                            .svg(width: 24, height: 24, color: grayColor800),
                        SizedBox(
                          width: 8,
                        ),
                        Assets.icon.outline.volumeHigh
                            .svg(width: 24, height: 24, color: grayColor800),
                      ],
                    ),
                    Row(
                      children: [
                        Assets.icon.outline.forward5Seconds
                            .svg(width: 24, height: 24, color: grayColor800),
                        SizedBox(
                          width: 8,
                        ),
                        Assets.icon.outline.backward5Seconds
                            .svg(width: 24, height: 24, color: grayColor800),
                        SizedBox(
                          width: 16,
                        ),
                        Assets.icon.outline.pause
                            .svg(width: 24, height: 24, color: primaryColor),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
