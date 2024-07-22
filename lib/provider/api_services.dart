import 'dart:convert';

import 'package:asset_tracker/resource/app_resource.dart';
import 'package:asset_tracker/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../models/alarm/alarm_model.dart';
import '../models/area/area_model.dart';
import '../models/asset/asset_model.dart';
import '../models/asset_report/asset_group_model.dart';
import '../models/dashboard/recent_asset_model.dart';
import '../models/locate/map_point.dart';
import '../models/locate/zone_area.dart';
import '../models/locate/zone_path_model.dart';
import '../models/login/new_login_model.dart';
import '../models/user/result.dart';
import '../models/user/user_model.dart';
import '../models/zone/zone_model.dart';
import '../utils/database_helper.dart';

/// Created by Chandan Jana on 11-10-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ApiServices {
  AreaModel? selectedArea;
  AssetModel? selectedAsset;
  AssetGroupModel? selectedGroup;
  final List<MapPoint> _pointList = [];

  Future<List<AreaModel>> loadArea() async {
    /// Here we getting/fetch data from server
    const String areaUrl = AppApi.getAllZoneAreaApi;

    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    if (kDebugMode) {
      Utils().logger.info('authToken $authToken');
    }

    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
      // Add other headers as needed, e.g., 'Authorization'
    };
    if (kDebugMode) {
      print('areaUrl $areaUrl');
      print('headers $headers');
    }

    final response = await http.get(Uri.parse(areaUrl), headers: headers);
    if (kDebugMode) {
      print('response.statusCode ${response.statusCode}');
    }
    if (response.statusCode == 200) {
      List responseBody = json.decode(response.body);
      List<AreaModel> areaList =
          responseBody.map((area) => AreaModel.fromJson(area)).toList();
      if (kDebugMode) {
        print('Area fetch. $responseBody');
      }
      return areaList;
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  Future<List<AlarmModel>> loadAlarms() async {
    /// Here we getting/fetch data from server
    const String alarmUrl = AppApi.getAlarmsApi;

    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    if (kDebugMode) {
      print('authToken $authToken');
    }

    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
      // Add other headers as needed, e.g., 'Authorization'
    };
    if (kDebugMode) {
      print('alarmUrl $alarmUrl');
      print('headers $headers');
    }

    final response = await http.get(Uri.parse(alarmUrl), headers: headers);
    if (kDebugMode) {
      print('response.statusCode ${response.statusCode}');
    }
    if (response.statusCode == 200) {
      List responseBody = json.decode(response.body);
      List<AlarmModel> areaList =
          responseBody.map((area) => AlarmModel.fromJson(area)).toList();
      if (kDebugMode) {
        print('Alarm fetch. $responseBody');
      }
      return areaList;
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  Future<List<AssetModel>> loadAllAsset() async {
    /// Here we getting/fetch data from server
    const String zoneUrl = AppApi.getAllAssetsApi;

    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    if (kDebugMode) {
      print('authToken $authToken');
    }

    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
      // Add other headers as needed, e.g., 'Authorization'
    };
    if (kDebugMode) {
      print('zoneUrl $zoneUrl');
      print('headers $headers');
    }

    final response = await http.get(Uri.parse(zoneUrl), headers: headers);
    if (kDebugMode) {
      print('response.statusCode ${response.statusCode}');
    }
    if (response.statusCode == 200) {
      List responseBody = json.decode(response.body);
      List<AssetModel> areaList =
          responseBody.map((area) => AssetModel.fromJson(area)).toList();
      if (kDebugMode) {
        print('Zone fetch. $responseBody');
      }
      return areaList;
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  Future<List<RecentAssetModel>> loadRecentAsset() async {
    /// Here we getting/fetch data from server
    const String assetUrl = AppApi.getTop10AssetReportApi;

    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    if (kDebugMode) {
      print('authToken $authToken');
    }

    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
      // Add other headers as needed, e.g., 'Authorization'
    };
    if (kDebugMode) {
      print('assetUrl $assetUrl');
      print('headers $headers');
    }
    final response = await http.get(Uri.parse(assetUrl), headers: headers);
    if (kDebugMode) {
      print('response.statusCode ${response.statusCode}');
    }
    if (response.statusCode == 200) {
      List responseBody = json.decode(response.body);
      List<RecentAssetModel> areaList =
          responseBody.map((area) => RecentAssetModel.fromJson(area)).toList();
      if (kDebugMode) {
        print('All Asset fetch. $responseBody');
      }
      return areaList;
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  Future<ZonePathModel> loadAreaById({required int? areaId}) async {
    /// Here we getting/fetch data from server

    if (areaId != null) {
      String areaUrl =
          '${AppApi.getZonesPathByAreaIdApi}${areaId.toString()}';

      // Create storage
      const storage = FlutterSecureStorage();
      // Read token value
      String? authToken = await storage.read(key: AppDatabase.token);
      if (kDebugMode) {
        print('authToken $authToken');
      }

      final Map<String, String> headers = {
        AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
        AppApiKey.acceptKey: AppApiKey.acceptValue,
        AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
        // Add other headers as needed, e.g., 'Authorization'
      };
      if (kDebugMode) {
        print('areaUrl $areaUrl');
        print('headers $headers');
      }
      final response = await http.get(Uri.parse(areaUrl), headers: headers);
      if (kDebugMode) {
        print('response.statusCode ${response.statusCode}');
      }
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (kDebugMode) {
          print('Area fetch. $responseBody');
        }
        ZonePathModel areaList = ZonePathModel.fromJson(responseBody);
        await _calculatePoint(areaList.zoneAreas!);
        return areaList;
      } else {
        throw Exception(
            'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
      }
    }
    throw Exception('Failed to fetch data. Please try again later!');
  }

  Future<ZonePathModel> loadAssetById({required int? assetId}) async {
    /// Here we getting/fetch data from server

    if (assetId != null) {
      String areaUrl =
          '${AppApi.getCurrentAssetLocationApi}${assetId.toString()}';

      // Create storage
      const storage = FlutterSecureStorage();
      // Read token value
      String? authToken = await storage.read(key: AppDatabase.token);
      if (kDebugMode) {
        print('authToken $authToken');
      }

      final Map<String, String> headers = {
        AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
        AppApiKey.acceptKey: AppApiKey.acceptValue,
        AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
        // Add other headers as needed, e.g., 'Authorization'
      };
      if (kDebugMode) {
        print('assetUrl $areaUrl');
        print('headers $headers');
      }
      final response = await http.get(Uri.parse(areaUrl), headers: headers);
      if (kDebugMode) {
        print('response.statusCode ${response.statusCode}');
      }
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (kDebugMode) {
          print('Asset fetch. $responseBody');
        }
        ZonePathModel areaList = ZonePathModel.fromJson(responseBody);
        await _calculatePoint(areaList.zoneAreas!);
        return areaList;
      } else {
        throw Exception(
            'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
      }
    }
    throw Exception('Failed to fetch data. Please try again later!');
  }

  Future<List<ZoneModel>> loadZone() async {
    /// Here we getting/fetch data from server
    const String zoneUrl = AppApi.getAllZonesApi;

    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    if (kDebugMode) {
      print('authToken $authToken');
    }

    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
      // Add other headers as needed, e.g., 'Authorization'
    };
    if (kDebugMode) {
      print('zoneUrl $zoneUrl');
      print('headers $headers');
    }
    final response = await http.get(Uri.parse(zoneUrl), headers: headers);
    if (kDebugMode) {
      print('response.statusCode ${response.statusCode}');
    }
    if (response.statusCode == 200) {
      List responseBody = json.decode(response.body);
      List<ZoneModel> areaList =
          responseBody.map((area) => ZoneModel.fromJson(area)).toList();
      if (kDebugMode) {
        print('Zone fetch. $responseBody');
      }
      return areaList;
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  Future<List<AssetGroupModel>> loadAllAssetGroup() async {
    /// Here we getting/fetch data from server
    const String zoneUrl = AppApi.getAllAssetGroupsApi;

    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    if (kDebugMode) {
      print('authToken $authToken');
    }

    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
      // Add other headers as needed, e.g., 'Authorization'
    };
    if (kDebugMode) {
      print('assetGroupUrl $zoneUrl');
      print('headers $headers');
    }
    final response = await http.get(Uri.parse(zoneUrl), headers: headers);
    if (kDebugMode) {
      print('response.statusCode ${response.statusCode}');
    }
    if (response.statusCode == 200) {
      List responseBody = json.decode(response.body);
      List<AssetGroupModel> areaList =
          responseBody.map((area) => AssetGroupModel.fromJson(area)).toList();
      if (kDebugMode) {
        print('Asset fetch. $responseBody');
      }
      return areaList;
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  Future<List<AssetModel>> loadAssetByGroupId({required int? groupId}) async {
    if (groupId != null) {
      /// Here we getting/fetch data from server
      String zoneUrl =
          '${AppApi.getAssetsByGroupIdApi}${groupId.toString()}';

      // Create storage
      const storage = FlutterSecureStorage();
      // Read token value
      String? authToken = await storage.read(key: AppDatabase.token);
      if (kDebugMode) {
        print('authToken $authToken');
      }

      final Map<String, String> headers = {
        AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
        AppApiKey.acceptKey: AppApiKey.acceptValue,
        AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
        // Add other headers as needed, e.g., 'Authorization'
      };
      if (kDebugMode) {
        print('assetUrl $zoneUrl');
        print('headers $headers');
      }

      final response = await http.get(Uri.parse(zoneUrl), headers: headers);
      if (kDebugMode) {
        print('response.statusCode ${response.statusCode}');
      }
      if (response.statusCode == 200) {
        List responseBody = json.decode(response.body);
        List<AssetModel> areaList =
            responseBody.map((area) => AssetModel.fromJson(area)).toList();
        if (kDebugMode) {
          print('Asset fetch. $responseBody');
        }
        return areaList;
      } else {
        throw Exception(
            'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
      }
    }

    throw Exception('Failed to fetch data. Please try again later!');
  }

  Future<bool> _calculatePoint(ZoneAreas zoneAreas) async {
    List<String> keys = zoneAreas.toJson()!.keys.toList();
    List<dynamic> values = zoneAreas.toJson()!.values.toList();
    for (var element in values) {
      // Ensure dynamicData is a list before converting
      List<Map<String, dynamic>> listOfMaps =
          List<Map<String, dynamic>>.from(json.decode(element));
      //if (element is List) {
      // Iterate over each item in the dynamic list
      for (var item in listOfMaps) {
        //if (item is Map<String, dynamic>) {
        Map<String, dynamic> map = Map<String, dynamic>.from(item);
        // Check if each item is a map
        _pointList.add(MapPoint(x: map['x'], y: map['y']));
        //}
      }
      //}
    }
    if (kDebugMode) {
      print('_pointList $_pointList');
    }
    return true;
  }

  Future<List<Result>> loadUsers() async {
    /// Here we getting/fetch data from server
    const String userUrl = AppApi.getAllUserApi;

    // Create storage
    const storage = FlutterSecureStorage();
    // Read token value
    String? authToken = await storage.read(key: AppDatabase.token);
    if (kDebugMode) {
      print('authToken $authToken');
    }

    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
      // Add other headers as needed, e.g., 'Authorization'
    };
    if (kDebugMode) {
      print('userUrl $userUrl');
      print('headers $headers');
    }
    final response = await http.get(Uri.parse(userUrl), headers: headers);
    if (kDebugMode) {
      print('response.statusCode ${response.statusCode}');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      UserModel areaList = UserModel.fromJson(responseBody);
      if (kDebugMode) {
        print('User fetch. $responseBody');
      }
      if (areaList.result != null) {
        return areaList.result!;
      } else {
        return [];
      }
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  Future<bool> login({required email, required password}) async {
    const String loginUrl = AppApi.loginApi;

    if (kDebugMode) {
      print('User login url $loginUrl');
    }
    final Map<String, String> headers = {
      AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
      AppApiKey.acceptKey: AppApiKey.acceptValue,
      // Add other headers as needed, e.g., 'Authorization'
    };
    final Map<String, dynamic> body = {
      AppApiKey.email: email,
      AppApiKey.password: password,
    };
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // Login was successful
      final responseBody = json.decode(response.body);
      if (kDebugMode) {
        print('User Login successful. $responseBody');
      }

      LoginResponseModel loginModel = LoginResponseModel.fromJson(responseBody);

      if (loginModel.isSuccess!) {
        String tempId = const Uuid().v4();
        int insertId = await DatabaseHelper().insert({
          AppDatabase.userId: tempId,
          AppDatabase.email: email,
          AppDatabase.token: loginModel.token,
          AppDatabase.name: loginModel.user!.firstName,
        });

        if (kDebugMode) {
          print('User insertId: $insertId');
        }
        // Create storage
        const storage = FlutterSecureStorage();
        // Write token value
        await storage.write(key: AppDatabase.token, value: loginModel.token);

        return true;
      } else {
        // Login failed
        if (kDebugMode) {
          print('User Login failed. Status code: ${response.statusCode}');
        }
        return false;
      }
    }
    return false;
  }
}

// Provider is great for accessing dependencies and objects that don’t change

final apiServicesProvider = Provider<ApiServices>((ref) => ApiServices());
