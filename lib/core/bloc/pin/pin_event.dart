part of 'pin_bloc.dart';

sealed class PinEvent {}

class PostOtp extends PinEvent {
  final AuthUserOtpRequest request;

  PostOtp(this.request);
}

class GetOtp extends PinEvent {
  final String phoneNumber;

  GetOtp(this.phoneNumber);
}
