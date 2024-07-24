import 'package:bloc/bloc.dart';

import '../../../data/model/new_course_card_model.dart';
import '../../../data/repository/categories_repository.dart';
import '../../enum/tags.dart';

class BooksHomeCubit extends Cubit<List<NewCourseCardModel>?> {
  BooksHomeCubit() : super(null);

  void getBooks() async {
    emit(null);
    try {
      List<NewCourseCardModel> response =
          await categoriesRepository.getCards([6], Tags.none);
      for (var element in response) {
        element.canStart = true;
      }
      emit(response);
    } catch (e) {
      emit([]);
    }
  }
}
