/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ChangePasswordModel {
  bool? isSuccess;
  String? errorMessage;
  String? errorDetails;
  bool? result;

  ChangePasswordModel(
      {this.isSuccess, this.errorMessage, this.errorDetails, this.result});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    errorMessage = json['errorMessage'];
    errorDetails = json['errorDetails'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['errorMessage'] = this.errorMessage;
    data['errorDetails'] = this.errorDetails;
    data['result'] = this.result;
    return data;
  }
}
