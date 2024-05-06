class AuthUserOtpError {
  Message? message;
  int? statusCode;
  String? timestamp;
  String? path;

  AuthUserOtpError(
      {this.message, this.statusCode, this.timestamp, this.path});

  AuthUserOtpError.fromJson(Map<String, dynamic> json) {
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['timestamp'] = this.timestamp;
    data['path'] = this.path;
    return data;
  }
}

class Message {
  String? message;
  int? statusCode;

  Message({this.message, this.statusCode});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}