/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class PieChartModel {
  PieChartModel({
    required this.assetType,
    required this.assetCount,
  });

  final String assetType;
  final int assetCount;

  factory PieChartModel.fromJson(Map<String, dynamic> json) => PieChartModel(
        assetType: json['assetType'],
        assetCount: json['assetCount'],
      );

  Map<String, dynamic> toJson() => {
        'assetType': assetType,
        'assetCount': assetCount,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
