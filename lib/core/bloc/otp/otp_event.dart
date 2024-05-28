part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class GetOtpEvent extends OtpEvent{
  final String phoneNumber;

  GetOtpEvent(this.phoneNumber);
}

class PostUserEvent extends OtpEvent{
  final AuthLoginUserRequest request;

  PostUserEvent(this.request);
}
class NavigatePinEvent extends OtpEvent{
}


