/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class Area {
  int? id;
  String? name;
  String? address;
  String? layoutImageUrl;

  Area({this.id, this.name, this.address, this.layoutImageUrl});

  Area.fromJson(Map<String, dynamic> json) {
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
