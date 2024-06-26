import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';

final learningRepository = LearningRepository(DioHelper());

class LearningRepository implements Learning {
  final DioHelper dioHelper;

  LearningRepository(this.dioHelper);

  @override
  Future<List<NewCourseCardModel>> getCards(String path) async {
    try {
      Response response = await dioHelper.getRequest(ApiEndPoints.mainCourse+path,null);
      final List<dynamic> postMaps = response.data;
      return postMaps.map((e) => NewCourseCardModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Learning {
  Future<List<NewCourseCardModel>> getCards(String path);
}
