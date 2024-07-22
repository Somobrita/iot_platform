/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class Permissions {
  String? permissionName;
  bool? isEnabled;

  Permissions({this.permissionName, this.isEnabled});

  Permissions.fromJson(Map<String, dynamic> json) {
    permissionName = json['permissionName'];
    isEnabled = json['isEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['permissionName'] = permissionName;
    data['isEnabled'] = isEnabled;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
