class AuthUserOtpResponse {
  String? otp;

  AuthUserOtpResponse({this.otp});

  AuthUserOtpResponse.fromJson(Map<String, dynamic> json) {
    otp = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pin'] = this.otp;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

