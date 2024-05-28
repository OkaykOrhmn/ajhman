part of 'smart_schedule_bloc.dart';

@immutable
sealed class SmartScheduleEvent {}

class SmartScheduleShowDialog extends SmartScheduleEvent {}

class SmartScheduleToCalender extends SmartScheduleEvent {}

class SmartScheduleToTime extends SmartScheduleEvent {}

class SmartScheduleToTimer extends SmartScheduleEvent {}

class SmartScheduleToSuccess extends SmartScheduleEvent {}
