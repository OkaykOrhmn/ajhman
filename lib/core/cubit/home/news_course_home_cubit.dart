import 'package:bloc/bloc.dart';

import '../../../data/model/cards/new_course_card_model.dart';
import '../../../data/repository/categories_repository.dart';
import '../../enum/tags.dart';

class NewsCourseHomeCubit extends Cubit<List<NewCourseCardModel>?> {
  NewsCourseHomeCubit() : super(null);

  void getNews() async {
    emit(null);
    try {
      List<NewCourseCardModel> response =
          await categoriesRepository.getCards([1, 2, 3], Tags.none);
      for (var element in response) {
        element.canStart = true;
      }
      emit(response);
    } catch (e) {
      emit([]);
    }
  }
}
