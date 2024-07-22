import 'package:asset_tracker/models/locate/zone_area.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ZonePathModel {
  int? areaId;
  String? areaName;
  String? areaImage;
  String? address;
  String? time;
  ZoneAreas? zoneAreas;
  ZoneAreas? zoneName;

  ZonePathModel(
      {this.areaId,
      this.areaName,
      this.areaImage,
      this.address,
      this.time,
      this.zoneAreas,
      this.zoneName});

  ZonePathModel.fromJson(Map<String, dynamic> json) {
    areaId = json['areaId'];
    areaName = json['areaName'];
    areaImage = json['areaImage'];
    address = json['address'];
    time = json['time'];
    zoneAreas = json['zoneAreas'] != null
        ? ZoneAreas.fromJson(json['zoneAreas'])
        : null;
    zoneName =
        json['zoneName'] != null ? ZoneAreas.fromJson(json['zoneName']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['areaId'] = areaId;
    data['areaName'] = areaName;
    data['areaImage'] = areaImage;
    data['address'] = address;
    data['time'] = time;
    if (zoneAreas != null) {
      data['zoneAreas'] = zoneAreas!.toJson();
    }
    if (zoneName != null) {
      data['zoneName'] = zoneName!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
