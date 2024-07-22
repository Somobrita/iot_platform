/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class MapPoint {
  int? x;
  int? y;

  MapPoint({required this.x, required this.y});

  // Offset toOffset() => Offset(x as double, y as double);

  MapPoint.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['x'] = x;
    data['y'] = y;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
