/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetGroupModel {
  final int id;
  final String groupName;
  final String displayName;
  final String? parentId;

  AssetGroupModel(
      {required this.id,
      required this.groupName,
      required this.displayName,
      required this.parentId});

  factory AssetGroupModel.fromJson(Map<String, dynamic> json) =>
      AssetGroupModel(
        id: json['id'],
        groupName: json['groupName'],
        displayName: json['displayName'],
        parentId: json['parentId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupName': this.groupName,
        'displayName': this.displayName,
        'parentId': this.parentId,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
