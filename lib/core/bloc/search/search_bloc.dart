// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/new_course_card_model.dart';
import '../../../data/repository/course_repository.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is GetAllSearch) {
        emit(SearchLoading());
        try {
          List<NewCourseCardModel> response =
              await courseRepository.getSearch(event.type, event.search);
          if (response.isEmpty) {
            emit(SearchEmpty());
          } else {
            emit(SearchSuccess(response: response));
          }
        } on DioError {
          emit(SearchFail());
        }
      }

      if (event is ClearAllSearch) {
        emit(SearchInitial());
      }

      if (event is ClearAllSearch) {
        emit(SearchInitial());
      }

      if (event is TypingSearch) {
        emit(SearchLoading());
      }
    });
  }
}
