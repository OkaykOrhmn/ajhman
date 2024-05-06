part of 'auth_screen_bloc.dart';

@immutable
sealed class AuthScreensEvent {}

class AuthNavigateOtpEvent extends AuthScreensEvent{

}

class AuthNavigatePasswordEvent extends AuthScreensEvent{

}

class AuthNavigatePinEvent extends AuthScreensEvent{

}



