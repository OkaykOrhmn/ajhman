import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/new_course_card_model.dart';
import '../../../data/repository/categories_repository.dart';
import '../../enum/tags.dart';

class NewsCourseHomeCubit extends Cubit<List<NewCourseCardModel>?> {
  NewsCourseHomeCubit() : super(null);

  void getNews() async {
    emit(null);
    try {
      List<NewCourseCardModel> response =
          await categoriesRepository.getCards([1, 2, 3, 4, 5], Tags.none);
      for (var element in response) {
        element.canStart = true;
      }
      emit(response);
    } catch (e) {
      emit([]);
    }
  }
}
