class AuthUserOtpRequest {
  String? mobileNumber;
  String? otp;

  AuthUserOtpRequest({this.mobileNumber, this.otp});

  AuthUserOtpRequest.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNumber'] = mobileNumber.toString();
    data['otp'] = otp.toString();
    return data;
  }
}
