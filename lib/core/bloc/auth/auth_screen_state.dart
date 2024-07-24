part of 'auth_screen_bloc.dart';

enum AuthScreens { otp, password, pin, loading }

class AuthScreensState extends Equatable {
  final String phoneNumber;
  final String password;
  final String message;
  final AuthScreens authScreen;

  const AuthScreensState(
      {this.phoneNumber = "",
      this.password = "",
      this.message = "",
      this.authScreen = AuthScreens.otp});

  AuthScreensState copyWith(
      {String? phoneNumber,
      String? password,
      String? message,
      AuthScreens? authScreen}) {
    return AuthScreensState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        message: message ?? this.message,
        authScreen: authScreen ?? this.authScreen);
  }

  @override
  List<Object> get props => [phoneNumber, password, message, authScreen];
}
