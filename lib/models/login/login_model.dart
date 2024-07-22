import 'package:asset_tracker/resource/app_database.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class LoginModel {
  const LoginModel({
    required this.id,
    required this.email,
    required this.token,
    required this.name,
  });

  final String id;
  final String token;
  final String email;
  final String name;

  /// A factory constructor is a constructor that doesn't create a new
  /// instance of the class every time it's called. Instead, it returns an
  /// existing instance of the class or a different instance based on some
  /// logic within the constructor itself. Factory constructors are commonly
  /// used in situations where you want to control the creation of objects or
  /// return cached instances to optimize memory usage.

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      id: json[AppDatabase.userId],
      token: json[AppDatabase.token],
      email: json[AppDatabase.email],
      name: json[AppDatabase.name]);

  Map<String, dynamic> toJson() => {
        AppDatabase.userId: id,
        AppDatabase.token: token,
        AppDatabase.email: email,
        AppDatabase.name: name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
