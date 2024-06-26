class AuthLoginUserRsponse {
  Message? message;
  int? statusCode;
  String? timestamp;
  String? path;

  AuthLoginUserRsponse(
      {this.message, this.statusCode, this.timestamp, this.path});

  AuthLoginUserRsponse.fromJson(Map<String, dynamic> json) {
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
  String? error;
  int? statusCode;

  Message({this.message, this.error, this.statusCode});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['error'] = error;
    data['statusCode'] = statusCode;
    return data;
  }
}