part of 'course_main_bloc.dart';

@immutable
class CourseMainState extends Equatable {
  final StateStatus status;
  final String type;
  final dynamic data;

  const CourseMainState({this.status = StateStatus.loading, this.type = '', this.data});

  CourseMainState copyWith(
      {required StateStatus status,required String type, dynamic data}) {
    return CourseMainState(status: status , type: type, data: data ?? this.data);
  }

  @override
  List<Object> get props => [status, type];
}