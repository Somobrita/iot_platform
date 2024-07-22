/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class TabularViewModel {
  TabularViewModel(
      {required this.assetName,
      required this.zoneName,
      required this.gateWay,
      required this.serialNo,
      required this.startTime});

  final String zoneName;
  final String assetName;
  final String gateWay;
  final String serialNo;
  final String startTime;

  /// A factory constructor is a constructor that doesn't create a new
  /// instance of the class every time it's called. Instead, it returns an
  /// existing instance of the class or a different instance based on some
  /// logic within the constructor itself. Factory constructors are commonly
  /// used in situations where you want to control the creation of objects or
  /// return cached instances to optimize memory usage.

  factory TabularViewModel.fromJson(Map<String, dynamic> json) =>
      TabularViewModel(
        assetName: json['assetName'],
        zoneName: json['zoneName'],
        gateWay: json['gateWay'],
        serialNo: json['serialNo'],
        startTime: json['startTime'],
      );

  Map<String, dynamic> toJson() => {
        'assetName': assetName,
        'zoneName': zoneName,
        'gateWay': gateWay,
        'serialNo': serialNo,
        'startTime': startTime,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
