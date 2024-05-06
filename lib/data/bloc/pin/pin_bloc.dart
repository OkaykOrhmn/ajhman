import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../model/auth/auth_user_otp_error.dart';
import '../../model/auth/auth_user_otp_request.dart';
import '../../model/auth/auth_user_otp_response.dart';
import '../../repository/auth_user_otp_repository.dart';

part 'pin_event.dart';

part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  PinBloc() : super(PinInitial()) {
    on<PinEvent>((event, emit) async {
      emit(PinLoadingState());
      if (event is PostOtp) {
        try {
          AuthUserToken response =
              await authLoginUserRepository.postOtp(event.request);
          emit(PinSuccessState(response.token.toString()));
        } on DioError catch (e) {
          AuthUserOtpError error = AuthUserOtpError.fromJson(e.response!.data);
          emit(PinErrorState(error.message!.message.toString()));
        }
      }

      if (event is GetOtp) {
        try {
          Response response =
              await authLoginUserRepository.getOtp(event.phoneNumber);
          if (response.statusCode! >= 200 && response.statusCode! <= 300) {
            emit(PinGetAgainState());
          } else {
            emit(PinErrorState("دوباره تلاش کنید"));
          }
        } on DioError catch (e) {
          AuthUserOtpError error = AuthUserOtpError.fromJson(e.response!.data);
          emit(PinErrorState(error.message!.message.toString()));
        }
      }
    });
  }
}
