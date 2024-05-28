class AuthLoginUserRequest {
  String? mobileNumber;
  String? password;

  AuthLoginUserRequest({this.mobileNumber, this.password});

  AuthLoginUserRequest.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['password'] = this.password;
    return data;
  }
}
