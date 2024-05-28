part of 'otp_bloc.dart';

enum OtpStatus { start,back, success, error, loading }

@immutable
class OtpState extends Equatable {
  final String message;
   OtpStatus otpStatus;

   OtpState(
      {
      this.message = "",
      this.otpStatus = OtpStatus.start});

  OtpState copyWith(
      {String? phoneNumber,
      String? code,
      String? message,
      OtpStatus? otpStatus}) {
    return OtpState(
        message: message ?? this.message,
        otpStatus: otpStatus ?? this.otpStatus);
  }

  @override
  List<Object> get props => [ message, otpStatus];
}

