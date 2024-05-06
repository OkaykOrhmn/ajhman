part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class GetOtpEvent extends OtpEvent{
  final String phoneNumber;

  GetOtpEvent(this.phoneNumber);
}
class NavigatePinEvent extends OtpEvent{
}


