import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/data/model/roadmap_model.dart';
import 'package:ajhman/data/repository/course_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../data/api/api_end_points.dart';
import '../../../enum/state_status.dart';

part 'course_main_event.dart';
part 'course_main_state.dart';

class CourseMainBloc extends Bloc<CourseMainEvent, CourseMainState> {
  CourseMainBloc() : super(const CourseMainState()) {
    on<CourseMainEvent>((event, emit) async{

      if (event is GetCourseMainInfo) {
        var result = state;
        var type = ApiEndPoints.mainCourse;
        emit(result.copyWith(status: StateStatus.loading, type: type));
        try {
          CourseMainResponseModel response = await courseRepository.getMainCurse(event.courseId);
          result = CourseMainState(
              status: StateStatus.success, type: type, data: response);
          emit(result);
        } on DioError catch (e) {
          result = CourseMainState(
              status: StateStatus.fail, type: type, data: null);
          emit(result);
        }
      }

    });
  }
}
