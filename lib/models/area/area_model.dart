/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AreaModel {
  int? id;
  String? name;
  String? address;
  String? layoutImageUrl;

  AreaModel({this.id, this.name, this.address, this.layoutImageUrl});

  /// A factory constructor is a constructor that doesn't create a new
  /// instance of the class every time it's called. Instead, it returns an
  /// existing instance of the class or a different instance based on some
  /// logic within the constructor itself. Factory constructors are commonly
  /// used in situations where you want to control the creation of objects or
  /// return cached instances to optimize memory usage.

  AreaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    layoutImageUrl = json['layoutImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['layoutImageUrl'] = layoutImageUrl;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
