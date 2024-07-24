// ignore_for_file: deprecated_member_use

import 'package:ajhman/data/model/planner_request_model.dart';
import 'package:ajhman/data/repository/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

      if (event is PutPlanner) {
        emit(SmartScheduleLoading());
        try {
          await profileRepository.putPlanner(event.plannerRequestModel);
          emit(SmartScheduleSuccess());
        } on DioError catch (e) {
          emit(SmartScheduleError(e.message.toString()));
        }
      }
    });
  }
}
