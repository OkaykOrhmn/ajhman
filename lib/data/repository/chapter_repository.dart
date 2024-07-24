import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/model/chapter_model.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';

final chapterRepository = ChapterRepository(DioHelper());

class ChapterRepository implements Chapter {
  final DioHelper dioHelper;

  ChapterRepository(this.dioHelper);

  @override
  Future<ChapterModel> getChapter(int chapter, int subchapter) async {
    try {
      Response response = await dioHelper.getRequest(
          "${ApiEndPoints.chapter}/$chapter${ApiEndPoints.subchapter}/$subchapter",
          null);
      final postMaps = response.data;
      return ChapterModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Chapter {
  Future<ChapterModel> getChapter(int chapter, int subchapter);
}
