import 'package:asset_tracker/models/dashboard/recent_asset_model.dart';
import 'package:asset_tracker/provider/api_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../widgets/error_screen.dart';
import '../../widgets/no_data_screen.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AllAssetsScreen extends ConsumerStatefulWidget {
  const AllAssetsScreen({super.key});

  @override
  ConsumerState<AllAssetsScreen> createState() => _AllAssetsScreenState();
}

class _AllAssetsScreenState extends ConsumerState<AllAssetsScreen> {
  void _reload() {
    ref.invalidate(loadRecentAssetProvider);
    ref.read(loadRecentAssetProvider);
  }

  @override
  void initState() {
    super.initState();
    ref.read(loadRecentAssetProvider);
  }

  @override
  Widget build(BuildContext context) {
    final recentAssetData = ref.watch(loadRecentAssetProvider);
    return recentAssetData.when(
      data: (data) {
        List<RecentAssetModel> reacentAssetList = data.map((e) => e).toList();
        if (reacentAssetList.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: NoDataScreen(onRetry: _reload),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  title: Text(
                    reacentAssetList[index].assetname!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(reacentAssetList[index].serialno!),
                      Text(reacentAssetList[index].zonename!),
                      Text(reacentAssetList[index].gatewayid!),
                      //Text(snapshot.data![index].notes!),
                      Text(reacentAssetList[index].assetgroup!),
                      Text(
                        // Format the datetime as needed
                        "${DateFormat('MMM d, y').format(DateTime.parse(reacentAssetList[index].startdate!))} - ${DateFormat('MMM d, y').format(DateTime.parse(reacentAssetList[index].enddate!))}",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  //trailing: Icon(Icons.assessment),
                  onTap: () {
                    // Handle row tap here
                  },
                ),
              ),
            );
          },
          itemCount: reacentAssetList.length,
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: ErrorScreen(errorMessage: error.toString(), onRetry: _reload),
        );
      },
      loading: () {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blueAccent,
            size: 70,
          ),
        );
      },
    );
    /*return FutureBuilder(
      future: _loadedItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.blueAccent,
              size: 70,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: ErrorScreen(
                errorMessage: snapshot.error.toString(), onRetry: _reload),
          );
        }

        if (snapshot.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: NoDataScreen(onRetry: _reload),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  title: Text(
                    snapshot.data![index].assetname!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data![index].serialno!),
                      Text(snapshot.data![index].zonename!),
                      Text(snapshot.data![index].gatewayid!),
                      //Text(snapshot.data![index].notes!),
                      Text(snapshot.data![index].assetgroup!),
                      Text(
                        // Format the datetime as needed
                        "${DateFormat('MMM d, y').format(DateTime.parse(snapshot.data![index].startdate!))} - ${DateFormat('MMM d, y').format(DateTime.parse(snapshot.data![index].enddate!))}",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  //trailing: Icon(Icons.assessment),
                  onTap: () {
                    // Handle row tap here
                  },
                ),
              ),
            );
          },
          itemCount: snapshot.data!.length,
        );
      },
    );*/
  }
}
