// ignore_for_file: deprecated_member_use

import 'package:ajhman/data/model/roadmap_model.dart';
import 'package:ajhman/data/repository/course_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../enum/state_status.dart';
part 'roadmap_event.dart';
part 'roadmap_state.dart';

class RoadmapBloc extends Bloc<RoadmapEvent, RoadmapState> {
  RoadmapBloc() : super(const RoadmapState()) {
    on<RoadmapEvent>((event, emit) async {
      if (event is GetRoadMap) {
        emit(const RoadmapState());
        var result = state;
        try {
          RoadmapModel response =
              await courseRepository.getRoadmap(event.courseId);
          result = RoadmapState(status: StateStatus.success, data: response);
          emit(result);
        } on DioError catch (e) {
          result =
              RoadmapState(status: StateStatus.fail, data: e.response!.data);
          emit(result);
        }
      }
    });
  }
}
