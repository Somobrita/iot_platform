/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class RecentAssetModel {
  String? assetgroup;
  String? assetname;
  String? serialno;
  String? zonename;
  String? gatewayid;
  String? startdate;
  String? enddate;
  String? notes;
  String? duration;

  RecentAssetModel(
      {this.assetgroup,
      this.assetname,
      this.serialno,
      this.zonename,
      this.gatewayid,
      this.startdate,
      this.enddate,
      this.notes,
      this.duration});

  // Deserialization
  RecentAssetModel.fromJson(Map<String, dynamic> json) {
    assetgroup = json['assetgroup'];
    assetname = json['assetname'];
    serialno = json['serialno'];
    zonename = json['zonename'];
    gatewayid = json['gatewayid'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    notes = json['notes'];
    duration = json['duration'];
  }

  // Serialization
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assetgroup'] = assetgroup;
    data['assetname'] = assetname;
    data['serialno'] = serialno;
    data['zonename'] = zonename;
    data['gatewayid'] = gatewayid;
    data['startdate'] = startdate;
    data['enddate'] = enddate;
    data['notes'] = notes;
    data['duration'] = duration;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
