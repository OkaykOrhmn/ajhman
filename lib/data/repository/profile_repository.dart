import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/model/planner_request_model.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';

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

  @override
  Future<Response> putPlanner(PlannerRequestModel plannerRequestModel) async {
    try {
      Response response = await dioHelper.putRequest(ApiEndPoints.planner,plannerRequestModel);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Response> putProfileImage(FormData  image) async {
    try {
      Response response = await dioHelper.putRequest(ApiEndPoints.userProfile,image);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Response> deleteProfileImage() async {
    try {
      Response response = await dioHelper.putRequest(ApiEndPoints.userProfile,null);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class ProfileInformation {
  Future<ProfileResponseModel> getProfile();
  Future<Response> deleteProfile();
  Future<Response> putPlanner(PlannerRequestModel plannerRequestModel);
  Future<Response> putProfileImage(FormData  image);
  Future<Response> deleteProfileImage();
}
