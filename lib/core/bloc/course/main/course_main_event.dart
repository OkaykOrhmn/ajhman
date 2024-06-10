part of 'course_main_bloc.dart';

@immutable
sealed class CourseMainEvent {}
class GetCourseMainInfo extends CourseMainEvent{
  final int courseId;

  GetCourseMainInfo({required this.courseId});
}

