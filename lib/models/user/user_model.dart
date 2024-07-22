import 'package:asset_tracker/models/user/result.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class UserModel {
  bool? isSuccess;
  String? errorMessage;
  String? errorDetails;
  List<Result>? result;

  UserModel(
      {this.isSuccess, this.errorMessage, this.errorDetails, this.result});

  UserModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    errorMessage = json['errorMessage'];
    errorDetails = json['errorDetails'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['errorMessage'] = errorMessage;
    data['errorDetails'] = errorDetails;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
