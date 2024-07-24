import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/data/model/chapter_model.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/audio/audio_player_wave.dart';
import 'package:ajhman/ui/widgets/dialogs/dialog_handler.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';

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
          InkWell(
            onTap: () {
              DialogHandler(context).showImageDialog(banner.source.toString());
            },
            child: PrimaryImageNetwork(
                // src:
                // "https://www.figma.com/file/Qe9pcE7Ts9ZtdwPvUUlBmA/image/ff1d273ecaa678018bbc0b2e8ad787cda708a713",
                src: banner.source.toString(),
                aspectRatio: 16 / 9),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.lowShadow,
                color: Theme.of(context).cardBackground()),
            child: AudioPlayerWave(
              source: audio.source.toString(),
              name: [
                context
                    .read<SubChapterCubit>()
                    .state
                    .courseData
                    .name
                    .toString(),
                data.name.toString()
              ],
            ),
          )
        ],
      ),
    );
  }
}
