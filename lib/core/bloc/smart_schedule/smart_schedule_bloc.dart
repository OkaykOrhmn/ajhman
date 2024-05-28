import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'smart_schedule_event.dart';

part 'smart_schedule_state.dart';

class SmartScheduleBloc extends Bloc<SmartScheduleEvent, SmartScheduleState> {
  SmartScheduleBloc() : super(SmartScheduleCalender()) {
    on<SmartScheduleEvent>((event, emit) async {
      if (event is SmartScheduleToCalender) {
        emit(SmartScheduleCalender());
      }
      if (event is SmartScheduleToTime) {
        emit(SmartScheduleTime());
      }

      if (event is SmartScheduleToTimer) {
        emit(SmartScheduleTimer());
      }

      if (event is SmartScheduleToSuccess) {
        emit(SmartScheduleSuccess());
      }
    });
  }
}
