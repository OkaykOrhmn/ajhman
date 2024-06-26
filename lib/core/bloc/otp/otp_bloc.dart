import 'package:ajhman/data/model/auth/auth_user_otp_error.dart';
import 'package:ajhman/data/model/auth/auth_user_otp_response.dart';
import 'package:ajhman/data/repository/auth_user_otp_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/model/auth/auth_login_user_request.dart';


part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super( OtpState()) {
    on<OtpEvent>((event, emit) async {
      if (event is GetOtpEvent) {
        try {
          Response response =
              await authLoginUserRepository.getOtp(event.phoneNumber);
          if (response.statusCode! >= 200 && response.statusCode! <= 300) {
            emit(state.copyWith(
                otpStatus: OtpStatus.success));
          } else {
            emit(state.copyWith(
                 otpStatus: OtpStatus.error));
          }
        } on DioError catch (e) {
          AuthUserOtpError error = AuthUserOtpError.fromJson(e.response!.data);
          emit(state.copyWith(
              otpStatus: OtpStatus.error,
              message: error.message!.message));
        }
      }

      if (event is PostUserEvent) {
        try {
          AuthUserToken response =
          await authLoginUserRepository.postLogin(event.request);
          emit(state.copyWith(
              otpStatus: OtpStatus.success));
                } on DioError catch (e) {
          AuthUserOtpError error = AuthUserOtpError.fromJson(e.response!.data);
          emit(state.copyWith(
              otpStatus: OtpStatus.error,
              message: error.message!.message));
        }
      }

      if(event is NavigatePinEvent){
        emit(state.copyWith(otpStatus: OtpStatus.back));

      }
    });
  }
}

Future<bool> responceIs(bool a) async{
  return a;
}
