import 'package:ajhman/ui/widgets/carousel/carousel_course_image.dart';
import 'package:flutter/cupertino.dart';

class CourseImage extends StatelessWidget{
  const CourseImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouseCourseImage(items: ["1","2","3","4"]);
  }

}