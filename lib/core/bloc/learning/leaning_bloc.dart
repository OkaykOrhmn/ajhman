import 'package:ajhman/data/model/new_course_card_model.dart';
import 'package:ajhman/data/repository/learning_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'leaning_event.dart';

part 'leaning_state.dart';

class LeaningBloc extends Bloc<LeaningEvent, LeaningState> {
  LeaningBloc() : super(LeaningInitial()) {
    on<LeaningEvent>((event, emit) async {
      if (event is GetCards) {
        emit(LeaningLoading());
        try {
          List<NewCourseCardModel> response =
              await learningRepository.getCards(event.path);
          if (response.isEmpty) {
            emit(LeaningEmpty());
          } else {
            emit(LeaningSuccess(response: response));
          }
        } on DioError {
          emit(LeaningFail());
        }
      }
      if (event is ClearCards) {
        emit(LeaningLoading());
      }
    });
  }
}
