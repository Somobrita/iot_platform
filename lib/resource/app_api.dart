/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AppApi {
  // Api Name
  //static const String _baseApi = 'http://192.168.10.202';
  static const String _baseApi = 'https://iotace.mindteck.com';
  static const String loginApi = '$_baseApi/devicehub/Authentication/Login';
  static const String logoutApi = '$_baseApi/devicehub/Authentication/Logout';
  static const String getAllSettingsApi =
      '$_baseApi/hatsapi/ApplicationSettings/GetAllSettings';
  static const String getAllAssetsApi = '$_baseApi/hatsapi/Asset/GetAllAssets';
  static const String getAssetByIdApi = '$_baseApi/hatsapi/Asset/GetAsset/';
  static const String getAssetByAssetTypeIdApi =
      '$_baseApi/hatsapi/Asset/GetAssetByType/';
  static const String getAssetByTypeAndNameApi =
      '$_baseApi/hatsapi/Asset/GetAssetByTypeAndName/';
  static const String getAllAssetTypesApi =
      '$_baseApi/hatsapi/Asset/GetAllAssetTypes';
  static const String getAllAssetGroupsApi =
      '$_baseApi/hatsapi/Asset/GetAllAssetGroups';
  static const String getAssetCountByGroupIdApi =
      '$_baseApi/hatsapi/Asset/GetAssetCountByGroup/';
  static const String getAssetByTypeIdApi =
      '$_baseApi/hatsapi/Asset/GetAssetByType/';
  static const String getAssetsByGroupIdApi =
      '$_baseApi/hatsapi/Asset/GetAssetsByGroup/';
  static const String getAllZoneAreaApi =
      '$_baseApi/hatsapi/Zone/GetAllZoneArea';
  static const String getAllZonesApi = '$_baseApi/hatsapi/Zone/GetAllZones';
  static const String getAlarmsApi = '$_baseApi/hatsapi/Report/GetAlarms';
  static const String getAllUserApi = '$_baseApi/devicehub/Users/GetAll';
  static const String getAllAssetByTypeApi =
      '$_baseApi/hatsapi/Report/GetAllAssetByType';
  static const String getTop10AssetReportApi =
      '$_baseApi/hatsapi/Report/GetTop10AssetReport';
  static const String getZonesPathByAreaIdApi =
      '$_baseApi/hatsapi/Zone/GetZonesPathByAreaId/';
  static const String getCurrentAssetLocationApi =
      '$_baseApi/hatsapi/Report/GetCurrentAssetLocation/';
  static const String changePasswordApi =
      '$_baseApi/devicehub/Users/ChangePassword';
}
