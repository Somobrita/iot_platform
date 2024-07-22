import 'asset_tags.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetModel {
  int? id;
  String? name;
  String? description;
  String? idCodeType;
  String? idCodeValue;
  String? assetStatus;
  String? homeZone;
  String? image;
  String? shortDescription;
  String? inductionDate;
  String? releaseDate;
  String? assetTypeName;
  List<AssetTags>? assetTags;
  String? groupName;
  String? parentGroupID;
  List<String>? properties;

  AssetModel(
      {this.id,
      this.name,
      this.description,
      this.idCodeType,
      this.idCodeValue,
      this.assetStatus,
      this.homeZone,
      this.image,
      this.shortDescription,
      this.inductionDate,
      this.releaseDate,
      this.assetTypeName,
      this.assetTags,
      this.groupName,
      this.parentGroupID,
      this.properties});

  AssetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    idCodeType = json['idCodeType'];
    idCodeValue = json['idCodeValue'];
    assetStatus = json['assetStatus'];
    homeZone = json['homeZone'];
    image = json['image'];
    shortDescription = json['shortDescription'];
    inductionDate = json['inductionDate'];
    releaseDate = json['releaseDate'];
    assetTypeName = json['assetTypeName'];
    if (json['assetTags'] != null) {
      assetTags = <AssetTags>[];
      json['assetTags'].forEach((v) {
        assetTags!.add(AssetTags.fromJson(v));
      });
    }
    groupName = json['groupName'];
    parentGroupID = json['parentGroupID'];
    if (json['properties'] != null) {
      properties = <String>[];
      json['properties'].forEach((v) {
        //properties!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['idCodeType'] = idCodeType;
    data['idCodeValue'] = idCodeValue;
    data['assetStatus'] = assetStatus;
    data['homeZone'] = homeZone;
    data['image'] = image;
    data['shortDescription'] = shortDescription;
    data['inductionDate'] = inductionDate;
    data['releaseDate'] = releaseDate;
    data['assetTypeName'] = assetTypeName;
    if (assetTags != null) {
      data['assetTags'] = assetTags!.map((v) => v.toJson()).toList();
    }
    data['groupName'] = groupName;
    data['parentGroupID'] = parentGroupID;
    if (properties != null) {
      //data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
