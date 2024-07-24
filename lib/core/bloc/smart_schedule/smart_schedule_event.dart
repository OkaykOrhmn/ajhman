part of 'smart_schedule_bloc.dart';

sealed class SmartScheduleEvent {}

class SmartScheduleShowDialog extends SmartScheduleEvent {}

class SmartScheduleToCalender extends SmartScheduleEvent {}

class SmartScheduleToTime extends SmartScheduleEvent {}

class SmartScheduleToTimer extends SmartScheduleEvent {}

class PutPlanner extends SmartScheduleEvent {
  final PlannerRequestModel plannerRequestModel;

  PutPlanner({required this.plannerRequestModel});
}
