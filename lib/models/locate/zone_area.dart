/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ZoneAreas {
  Map<String, dynamic>? mapValue;

  ZoneAreas({
    this.mapValue,
  });

  ZoneAreas.fromJson(Map<String, dynamic> json) {
    mapValue = json;
    List<String> keys = mapValue!.keys.toList();
    List<dynamic> values = mapValue!.values.toList();
  }

  Map<String, dynamic>? toJson() {
    return mapValue;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
