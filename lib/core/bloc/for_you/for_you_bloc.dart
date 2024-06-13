import 'package:ajhman/data/repository/course_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../data/model/cards/new_course_card_model.dart';

part 'for_you_event.dart';
part 'for_you_state.dart';

class ForYouBloc extends Bloc<ForYouEvent, ForYouState> {
  ForYouBloc() : super(ForYouInitial()) {
    on<ForYouEvent>((event, emit) async{
      if( event is GetAllForYou){
        emit(ForYouLoading());
        try {
          List<NewCourseCardModel> response =
          await courseRepository.getForYou();

          emit(ForYouSuccess(response: response));
        } on DioError catch (e) {
          emit(ForYouFail());
        }
      }
    });
  }
}
