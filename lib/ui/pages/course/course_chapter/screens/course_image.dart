import 'package:ajhman/ui/widgets/carousel/carousel_course_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubit/subchapter/sub_chapter_cubit.dart';

class CourseImage extends StatelessWidget{
  const CourseImage({super.key});

  @override
  Widget build(BuildContext context) {
   final data = context.read<SubChapterCubit>().state.chapterModel;

    return CarouseCourseImage(items: data.media!);
  }

}