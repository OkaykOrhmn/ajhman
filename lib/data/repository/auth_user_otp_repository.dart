import 'package:ajhman/data/api/dio_helper.dart';
import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_request.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:dio/dio.dart';

import '../api/api_end_points.dart';

final authLoginUserRepository = AuthLoginUserRepository(DioHelper());

class AuthLoginUserRepository implements AuthRegisterUserOtp {
  final DioHelper dioHelper;

  AuthLoginUserRepository(this.dioHelper);

  @override
  Future<int?> getOtp(String number) async {
    try {
      Response response = await dioHelper.sendRequest
          .get("${ApiEndPoints.authRegisterUserOtp}/$number");
      final postMaps = response.data;
      return response.statusCode;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<AuthUserToken> postOtp(AuthUserOtpRequest request) async {
    try {
      Response response = await dioHelper.sendRequest
          .post(ApiEndPoints.authLoginUserOtp, data: request.toJson());
      final postMaps = response.data;
      return AuthUserToken.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<AuthUserToken> postLogin(AuthLoginUserRequest request) async {
    try {
      Response response = await dioHelper.sendRequest
          .post(ApiEndPoints.authLoginUserPassword, data: request.toJson());
      final postMaps = response.data;
      return AuthUserToken.fromJson(postMaps);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class AuthRegisterUserOtp {
  Future<int?> getOtp(String phoneNumber);

  Future<AuthUserToken> postOtp(AuthUserOtpRequest request);

  Future<AuthUserToken> postLogin(AuthLoginUserRequest request);
}
