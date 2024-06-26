class AuthLoginUserRequest {
  String? mobileNumber;
  String? password;

  AuthLoginUserRequest({this.mobileNumber, this.password});

  AuthLoginUserRequest.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNumber'] = mobileNumber;
    data['password'] = password;
    return data;
  }
}
