/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AlarmModel {
  AlarmModel(
      {required this.assetName,
      required this.time,
      required this.serialNo,
      required this.zone,
      required this.description,
      required this.active});

  final String time;
  final String assetName;
  final String serialNo;
  final String zone;
  final String description;
  final String active;

  /// A factory constructor is a constructor that doesn't create a new
  /// instance of the class every time it's called. Instead, it returns an
  /// existing instance of the class or a different instance based on some
  /// logic within the constructor itself. Factory constructors are commonly
  /// used in situations where you want to control the creation of objects or
  /// return cached instances to optimize memory usage.

  factory AlarmModel.fromJson(Map<String, dynamic> json) => AlarmModel(
        assetName: json['assetName'],
        time: json['time'],
        serialNo: json['serialNo'],
        zone: json['zone'],
        description: json['description'],
        active: json['active'],
      );

  Map<String, dynamic> toJson() => {
        'assetName': assetName,
        'time': time,
        'serialNo': serialNo,
        'zone': zone,
        'description': description,
        'active': active,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
