class AuthUserOtpResponse {
  String? otp;

  AuthUserOtpResponse({this.otp});

  AuthUserOtpResponse.fromJson(Map<String, dynamic> json) {
    otp = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pin'] = otp;
    return data;
  }
}

class AuthUserToken {
  String? token;

  AuthUserToken({this.token});

  AuthUserToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
