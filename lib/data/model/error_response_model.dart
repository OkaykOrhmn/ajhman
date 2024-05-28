class ErrorResponseModel {
  Message? message;
  int? statusCode;
  String? timestamp;
  String? path;

  ErrorResponseModel(
      {this.message, this.statusCode, this.timestamp, this.path});

  ErrorResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? error;
  int? statusCode;

  Message({this.message, this.error, this.statusCode});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['statusCode'] = this.statusCode;
    return data;
  }
}