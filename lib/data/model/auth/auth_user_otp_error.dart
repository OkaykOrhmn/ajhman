class AuthUserOtpError {
  Message? message;
  int? statusCode;
  String? timestamp;
  String? path;

  AuthUserOtpError(
      {this.message, this.statusCode, this.timestamp, this.path});

  AuthUserOtpError.fromJson(Map<String, dynamic> json) {
    message =
    json['message'] != null ? Message.fromJson(json['message']) : null;
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    data['statusCode'] = statusCode;
    data['timestamp'] = timestamp;
    data['path'] = path;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}