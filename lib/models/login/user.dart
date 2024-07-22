import 'package:asset_tracker/models/login/permission.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class User {
  String? email;
  String? firstName;
  String? lastName;
  bool? isEnabled;
  String? password;
  String? role;
  List<Permissions>? permissions;

  User(
      {this.email,
      this.firstName,
      this.lastName,
      this.isEnabled,
      this.password,
      this.role,
      this.permissions});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    isEnabled = json['isEnabled'];
    password = json['password'];
    role = json['role'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['isEnabled'] = isEnabled;
    data['password'] = password;
    data['role'] = role;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
