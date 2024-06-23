import 'package:ajhman/core/enum/tags.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/data/repository/categories_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState()) {
    on<CategoryEvent>((event, emit) async{
      if(event is GetAllCategoryCards){
        emit(CategoryLoadingState());
        try {
          List<NewCourseCardModel> response = await categoriesRepository.getCards(event.categories,event.tag);
          for (var element in response) {
            element.canStart = true;
          }
          emit(CategorySuccessState(newsCards: response));
        } on DioError catch (e) {
          emit(CategoryFailState());

        }
      }
    });
  }
}
