import 'package:ajhman/data/model/course_main_response_model.dart';
import 'package:ajhman/data/model/roadmap_model.dart';
import 'package:ajhman/data/repository/course_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';


part 'course_main_event.dart';

part 'course_main_state.dart';

class CourseMainBloc extends Bloc<CourseMainEvent, CourseMainState> {
  CourseMainBloc() : super(CourseMainState()) {
    on<CourseMainEvent>((event, emit) async {
      if (event is GetRoadMap) {
        emit(CourseMainLoading());
        try {
          RoadmapModel response =
              await courseRepository.getRoadmap(event.courseId);

          if (response.chapters!.isEmpty) {
            emit(CourseRoadmapEmpty());
          } else {
            emit(CourseRoadmapSuccess(response: response));
          }
        } on DioError {
          emit(CourseMainFail());
        }
      }

      if (event is GetCourseMainInfo) {
        // emit(CourseMainLoading());

        try {
          CourseMainResponseModel response =
              await courseRepository.getMainCurse(event.courseId);
          for (var element in response.chapters!) {
            element.isOpen = false;
          }
          emit(CourseMainSuccess(response: response));
        } on DioError {
          emit(CourseMainFail());
        }
      }
    });
  }
}
