part of 'course_main_bloc.dart';

class CourseMainState {}

class CourseMainInitial extends CourseMainState {}

class CourseMainLoading extends CourseMainState {}

class CourseRoadmapEmpty extends CourseMainState {}

class CourseRoadmapSuccess extends CourseMainState {
  final RoadmapModel response;

  CourseRoadmapSuccess({required this.response});
}

class CourseMainSuccess extends CourseMainState {
  final CourseMainResponseModel response;

  CourseMainSuccess({required this.response});
}

class CourseMainFail extends CourseMainState {}
