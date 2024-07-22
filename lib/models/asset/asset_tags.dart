/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetTags {
  int? id;
  int? componentTypeId;
  String? componentValue;

  AssetTags({this.id, this.componentTypeId, this.componentValue});

  AssetTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    componentTypeId = json['componentTypeId'];
    componentValue = json['componentValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['componentTypeId'] = componentTypeId;
    data['componentValue'] = componentValue;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
