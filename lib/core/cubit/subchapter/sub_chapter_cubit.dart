import 'package:ajhman/data/args/course_args.dart';
import 'package:bloc/bloc.dart';


class SubChapterCubit extends Cubit<CourseArgs> {
  SubChapterCubit(super.courseArgs);

  CourseArgs getData(){
    return state;
  }

  void setData(CourseArgs courseArgs){
    emit(courseArgs);
  }
}
