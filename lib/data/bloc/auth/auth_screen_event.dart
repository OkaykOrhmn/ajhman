part of 'auth_screen_bloc.dart';

@immutable
sealed class AuthScreensEvent {}

class AuthNavigateOtpEvent extends AuthScreensEvent{
  String phoneNumber;
  AuthNavigateOtpEvent({this.phoneNumber = ""});
}

class AuthNavigatePasswordEvent extends AuthScreensEvent{

}

class AuthNavigatePinEvent extends AuthScreensEvent{
  String phoneNumber;
  AuthNavigatePinEvent({this.phoneNumber = ""});
}



