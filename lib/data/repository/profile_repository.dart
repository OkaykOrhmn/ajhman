import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/api/options.dart';
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
      Response response = await dioHelper.getRequest(ApiEndPoints.profile,null);
      final postMaps = response.data;
      return ProfileResponseModel.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }


  @override
  Future<Response> deleteProfile() async {
    try {
      Response response = await dioHelper.deleteRequest(ApiEndPoints.userProfile,null);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class ProfileInformation {
  Future<ProfileResponseModel> getProfile();
  Future<Response> deleteProfile();
}
