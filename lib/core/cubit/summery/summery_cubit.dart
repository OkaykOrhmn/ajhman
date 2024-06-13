import 'package:ajhman/data/model/summary_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/course_repository.dart';


class SummeryCubit extends Cubit<SummaryModel> {
  SummeryCubit() : super(SummaryModel());


  void getSummery(int id) async {
    try {
      SummaryModel response =
      await courseRepository.getSummery(id);

      emit(response);
    } on DioError catch (e) {
      emit(SummaryModel());
    }

  }
}
