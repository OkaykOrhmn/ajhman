import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_screen_event.dart';
part 'auth_screen_state.dart';

class AuthScreensBloc extends Bloc<AuthScreensEvent, AuthScreensState> {
  AuthScreensBloc() : super(const AuthScreensState()) {
    on<AuthScreensEvent>((event, emit) async {
      if (event is AuthNavigateOtpEvent) {
        emit(state.copyWith(
            authScreen: AuthScreens.otp, phoneNumber: event.phoneNumber));
      }
      if (event is AuthNavigatePasswordEvent) {
        emit(state.copyWith(authScreen: AuthScreens.password));
      }
      if (event is AuthNavigatePinEvent) {
        emit(state.copyWith(
            authScreen: AuthScreens.pin, phoneNumber: event.phoneNumber));
      }

/*
      if (event is AuthScreenEvent) {
        emit(state.copyWith(authStatus: event.status));
      }

      if (event is AuthChangeLoginEvent) {
        if (event.inOtp) {
          emit(state.copyWith(authStatus: AuthStatus.pin));
        } else {
          emit(state.copyWith(authStatus: AuthStatus.login_otp));
        }
      }

      if (event is AuthGetOtpEvent) {
        try {
          int? response =
              await authLoginUserRepository.getOtp(event.phoneNumber);
          emit(state.copyWith(
              authStatus: AuthStatus.pin, phoneNumber: event.phoneNumber));

        } on DioError catch (e) {
          emit(state.copyWith(
              phoneNumber: event.phoneNumber,
              authStatus: AuthStatus.error,
              message: AuthUserOtpError.fromJson(e.response!.data)
                  .message!
                  .message
                  .toString()));

        }
      }

      if (event is AuthPostOtpEvent) {
        try {
          AuthUserToken response =
              await authLoginUserRepository.postOtp(event.request);
          emit(state.copyWith(
              authStatus: AuthStatus.success, login_password: event.request.pin));
        } on DioError catch (e) {
          emit(state.copyWith(
              authStatus: AuthStatus.error,
              message: AuthUserOtpError.fromJson(e.response!.data)
                  .message!
                  .message
                  .toString()));
        }
      }

      if (event is AuthPostLoginEvent) {
        try {
          AuthUserToken response =
              await authLoginUserRepository.postLogin(event.request);
          emit(state.copyWith(authStatus: AuthStatus.success));
        } on DioError catch (e) {
          emit(state.copyWith(
              authStatus: AuthStatus.error,
              message: AuthUserOtpError.fromJson(e.response!.data)
                  .message!
                  .message
                  .toString()));
        }
      }*/
    });
  }
}
