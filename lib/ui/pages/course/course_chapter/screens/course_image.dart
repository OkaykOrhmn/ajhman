import 'package:ajhman/ui/widgets/carousel/carousel_course_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/bloc/chapter/chapter_bloc.dart';

class CourseImage extends StatelessWidget{
  const CourseImage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.read<ChapterBloc>().state.data!;

    return CarouseCourseImage(items: data.media!);
  }

}