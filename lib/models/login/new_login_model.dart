import 'package:asset_tracker/models/login/user.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class LoginResponseModel {
  User? user;
  String? token;
  String? message;
  String? messageDetails;
  bool? isSuccess;

  LoginResponseModel(
      {this.user,
      this.token,
      this.message,
      this.messageDetails,
      this.isSuccess});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    message = json['message'];
    messageDetails = json['messageDetails'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['message'] = message;
    data['messageDetails'] = messageDetails;
    data['isSuccess'] = isSuccess;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
