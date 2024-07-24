// ignore_for_file: deprecated_member_use

import 'package:ajhman/core/enum/tags.dart';
import 'package:ajhman/data/model/new_course_card_model.dart';
import 'package:ajhman/data/repository/categories_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState()) {
    on<CategoryEvent>((event, emit) async {
      if (event is GetAllCategoryCards) {
        emit(CategoryLoadingState());
        try {
          List<NewCourseCardModel> response =
              await categoriesRepository.getCards(event.categories, event.tag);
          for (var element in response) {
            element.canStart = true;
          }
          emit(CategorySuccessState(newsCards: response));
        } on DioError {
          emit(CategoryFailState());
        }
      }
    });
  }
}
