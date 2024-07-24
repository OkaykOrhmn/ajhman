import 'package:ajhman/data/api/dio_helper.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';

final bannerRepository = BannerRepository(DioHelper());

class BannerRepository implements Chapter {
  final DioHelper dioHelper;

  BannerRepository(this.dioHelper);

  @override
  Future<List<String>> getBanners() async {
    try {
      Response response = await dioHelper.getRequest(ApiEndPoints.banner, null);

      List<dynamic> postMaps = response.data;
      List<String> banners = [];
      for (var element in postMaps) {
        banners.add(element.toString());
      }
      return banners;
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class Chapter {
  Future<List<String>> getBanners();
}
