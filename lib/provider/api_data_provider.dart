import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/alarm/alarm_model.dart';
import '../models/area/area_model.dart';
import '../models/asset/asset_model.dart';
import '../models/asset_report/asset_group_model.dart';
import '../models/dashboard/recent_asset_model.dart';
import '../models/locate/zone_path_model.dart';
import '../models/user/result.dart';
import '../models/zone/zone_model.dart';
import '../resource/app_resource.dart';

/// Created by Chandan Jana on 11-10-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

// FutureProvider is great for read some async data from network/database

final areaListProvider = FutureProvider<List<AreaModel>>((ref) async {
  return ref.watch(apiServicesProvider).loadArea();
});

final alarmListProvider = FutureProvider<List<AlarmModel>>((ref) async {
  return ref.watch(apiServicesProvider).loadAlarms();
});

final assetListProvider = FutureProvider<List<AssetModel>>((ref) async {
  return ref.watch(apiServicesProvider).loadAllAsset();
});

final zoneListProvider = FutureProvider<List<ZoneModel>>((ref) async {
  return ref.watch(apiServicesProvider).loadZone();
});

final assetGroupListProvider =
    FutureProvider<List<AssetGroupModel>>((ref) async {
  return ref.watch(apiServicesProvider).loadAllAssetGroup();
});

final loadRecentAssetProvider =
    FutureProvider<List<RecentAssetModel>>((ref) async {
  return ref.watch(apiServicesProvider).loadRecentAsset();
});

final loadUserProvider = FutureProvider<List<Result>>((ref) async {
  return ref.watch(apiServicesProvider).loadUsers();
});

// StateProvider is great for storing simple state objects that can change

final areaModelStateProvider = StateProvider<AreaModel?>((ref) {
  return ref.read(apiServicesProvider).selectedArea;
});

final assetModelStateProvider = StateProvider<AssetModel?>((ref) {
  return ref.read(apiServicesProvider).selectedAsset;
});

final assetGroupModelStateProvider = StateProvider<AssetGroupModel?>((ref) {
  return ref.read(apiServicesProvider).selectedGroup;
});

// family is a modifier that we can use to pass an argument to a provider.

final loginProvider = FutureProvider.autoDispose
// additional areaId argument of type int
    .family<bool, Map<String, dynamic>>((ref, loginCredential) async {
  // get the repository
  final areaRepo = ref.watch(apiServicesProvider);
  // call method that returns a Future<ZonePathModel>, passing the areaId as an argument
  return areaRepo.login(
      email: loginCredential['email'], password: loginCredential['password']);
});

final areaByIdProvider = FutureProvider.autoDispose
// additional areaId argument of type int
    .family<ZonePathModel, int?>((ref, areaId) async {
  // get the repository
  final areaRepo = ref.watch(apiServicesProvider);
  // call method that returns a Future<ZonePathModel>, passing the areaId as an argument
  return areaRepo.loadAreaById(areaId: areaId);
});

final assetByIdProvider = FutureProvider.autoDispose
// additional assetId argument of type int
    .family<ZonePathModel, int?>((ref, assetId) async {
  // get the repository
  final assetRepo = ref.watch(apiServicesProvider);
  // call method that returns a Future<ZonePathModel>, passing the assetId as an argument
  return assetRepo.loadAssetById(assetId: assetId);
});

final assetByGroupIdProvider = FutureProvider.autoDispose
// additional groupId argument of type int
    .family<List<AssetModel>, int?>((ref, groupId) async {
  // get the repository
  final assetRepo = ref.watch(apiServicesProvider);
  // call method that returns a Future<List<AssetModel>>, passing the groupId as an argument
  return assetRepo.loadAssetByGroupId(groupId: groupId);
});
