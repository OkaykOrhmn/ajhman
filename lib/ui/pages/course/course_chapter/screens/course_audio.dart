import 'dart:math';

import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/core/services/audio_handler.dart';
import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/audio/audio_bar.dart';
import 'package:ajhman/ui/widgets/audio/audio_player_wave.dart';
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
  late ChapterModel data;
  late Media banner;
  late Media audio;

  @override
  void initState() {
    data = context.read<SubChapterCubit>().state.chapterModel;
    for (var element in data.media!) {
      if (element.type == CourseTypes.image.type) {
        banner = element;
      }
      if (element.type == CourseTypes.audio.type) {
        audio = element;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: AudioPlayerWave(
              source: audio.source.toString(),
              name: data.name.toString(),
            ),
          )
        ],
      ),
    );
  }
}
