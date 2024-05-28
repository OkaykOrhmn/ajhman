part of 'smart_schedule_bloc.dart';

@immutable
sealed class SmartScheduleState {}

final class SmartScheduleInitial extends SmartScheduleState {}

final class SmartScheduleCalender extends SmartScheduleState {}

final class SmartScheduleTime extends SmartScheduleState {}

final class SmartScheduleTimer extends SmartScheduleState {}

final class SmartScheduleError extends SmartScheduleState {
  final String error;

  SmartScheduleError(this.error);
}

final class SmartScheduleSuccess extends SmartScheduleState {}
