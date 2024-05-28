import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';
import '../model/auth/auth_login_user_rsponse.dart';

final profileRepository = ProfileRepository(DioHelper());

class ProfileRepository implements ProfileInformation {
  final DioHelper dioHelper;

  ProfileRepository(this.dioHelper);

  @override
  Future<ProfileResponseModel> getProfile() async {
    try {
      final t = await getToken();
      Response response = await dioHelper.sendRequest.get(ApiEndPoints.profile,
          options: Options(headers: {
            "Content-Type": "application/json",
            'accept': '*/*',
            'Authorization': "Bearer $t",
          }));
      final postMaps = response.data;
      return ProfileResponseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class ProfileInformation {
  Future<ProfileResponseModel> getProfile();
}
