import 'package:ajhman/data/args/course_args.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubChapterCubit extends Cubit<CourseArgs> {
  SubChapterCubit(super.courseArgs);

  CourseArgs getData() {
    return state;
  }

  void setData(CourseArgs courseArgs) {
    emit(courseArgs);
  }
}
