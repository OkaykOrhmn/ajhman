// ignore_for_file: deprecated_member_use

import 'package:ajhman/data/model/my_treasure_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/course_repository.dart';
part 'treasure_event.dart';
part 'treasure_state.dart';

class TreasureBloc extends Bloc<TreasureEvent, TreasureState> {
  TreasureBloc() : super(TreasureInitial()) {
    on<TreasureEvent>((event, emit) async {
      if (event is GetAllTreasure) {
        emit(TreasureLoading());
        try {
          MyTreasureModel response = await courseRepository.getTreasure();

          emit(TreasureSuccess(response: response));
        } on DioError {
          emit(TreasureFail());
        }
      }
    });
  }
}
