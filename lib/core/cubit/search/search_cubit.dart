// ignore_for_file: deprecated_member_use

import 'package:ajhman/data/model/new_course_card_model.dart';
import 'package:ajhman/data/repository/course_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<List<NewCourseCardModel>?> {
  SearchCubit() : super(null);

  void search(String? type, String search) async {
    try {
      List<NewCourseCardModel> response =
          await courseRepository.getSearch(type, search);

      emit(response);
    } on DioError {
      emit([]);
    }
  }

  void clear() async {
    emit([]);
  }
}
