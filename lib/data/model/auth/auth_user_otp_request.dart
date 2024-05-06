class AuthUserOtpRequest {
  String? mobileNumber;
  String? otp;

  AuthUserOtpRequest({this.mobileNumber, this.otp});

  AuthUserOtpRequest.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    otp = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['pin'] = this.otp;
    return data;
  }
}