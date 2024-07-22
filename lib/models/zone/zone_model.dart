import 'area.dart';
import 'iot_components.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ZoneModel {
  int? id;
  String? name;
  String? notes;
  String? image;
  bool? isIgnored;
  List<IotComponents>? iotComponents;
  int? zoneTypeID;
  String? zoneTypeName;
  List<String>? properties;
  int? areaId;
  Area? area;
  String? drawingPath;

  ZoneModel(
      {this.id,
      this.name,
      this.notes,
      this.image,
      this.isIgnored,
      this.iotComponents,
      this.zoneTypeID,
      this.zoneTypeName,
      this.properties,
      this.areaId,
      this.area,
      this.drawingPath});

  ZoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    notes = json['notes'];
    image = json['image'];
    isIgnored = json['isIgnored'];
    if (json['iotComponents'] != null) {
      iotComponents = <IotComponents>[];
      json['iotComponents'].forEach((v) {
        iotComponents!.add(IotComponents.fromJson(v));
      });
    }
    zoneTypeID = json['zoneTypeID'];
    zoneTypeName = json['zoneTypeName'];
    if (json['properties'] != null) {
      properties = <String>[];
      json['properties'].forEach((v) {
        //properties!.add(new Null.fromJson(v));
      });
    }
    areaId = json['areaId'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    drawingPath = json['drawingPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['notes'] = notes;
    data['image'] = image;
    data['isIgnored'] = isIgnored;
    if (iotComponents != null) {
      data['iotComponents'] = iotComponents!.map((v) => v.toJson()).toList();
    }
    data['zoneTypeID'] = zoneTypeID;
    data['zoneTypeName'] = zoneTypeName;
    if (properties != null) {
      //data['properties'] = properties!.map((v) => v.toJson()).toList();
    }
    data['areaId'] = areaId;
    if (area != null) {
      data['area'] = area!.toJson();
    }
    data['drawingPath'] = drawingPath;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
