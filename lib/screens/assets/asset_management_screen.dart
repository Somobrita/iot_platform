import 'package:asset_tracker/provider/api_data_provider.dart';
import 'package:asset_tracker/screens/assets/add_asset_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/asset/asset_model.dart';
import '../../utils/constants.dart';
import '../../widgets/asset_management_list_row.dart';
import '../../widgets/custom_search_delegate.dart';
import '../../widgets/error_screen.dart';
import '../../widgets/no_data_screen.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetManagementScreen extends ConsumerStatefulWidget {
  const AssetManagementScreen({super.key});

  @override
  ConsumerState<AssetManagementScreen> createState() =>
      _AssetManagementScreenState();
}

class _AssetManagementScreenState extends ConsumerState<AssetManagementScreen> {
  void _reload() {
    ref.invalidate(assetListProvider);
    ref.read(assetListProvider);
  }

  void _addNewAsset() async {
    final isAdded = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (context) {
        return const AddAssetScreen();
      },
    ));

    if (isAdded!) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Asset add feature available soon!',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(
          seconds: 5,
        ),
        backgroundColor: Colors.black,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    ref.read(assetListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final assetData = ref.watch(assetListProvider);
    return Scaffold(
      /// WillPopScope is a widget in the Flutter framework, which is used for
      /// controlling the behavior of the back button or the system navigation
      /// gestures on Android devices. It allows you to intercept and handle
      /// the back button press event to perform custom actions
      ///
      /// Inside the CustomScrollView, we add several Sliver widgets:
      //
      // SliverAppBar: A flexible app bar with a title.
      // SliverList: A scrollable list of items.
      // SliverGrid: A scrollable grid with cards.
      // SliverToBoxAdapter: A custom container with non-sliver content.
      // SliverFillRemaining: A custom container with fills all remaining space in a
      // scroll view, and lays a box widget out inside that space.
      body: CustomScrollView(
        primary: true,
        slivers: <Widget>[
          SliverAppBar(
            forceElevated: true,
            elevation: 4,
            floating: true,
            pinned: true,
            title: Text(
              Constants.assetManagement,
              style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  assetData.when(
                    data: (data) {
                      List<AssetModel> assetList = data.map((e) => e).toList();
                      return showSearch(
                        context: context,
                        delegate: CustomSearchDelegate<AssetModel>(
                            optionName: Constants.assetManagement,
                            searchList: assetList),
                      );
                    },
                    error: (error, stackTrace) {},
                    loading: () {},
                  );
                },
              ),
              IconButton(
                onPressed: _addNewAsset,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: _reload,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SliverFillRemaining(
            child: assetData.when(
              data: (data) {
                List<AssetModel> assetList = data.map((e) => e).toList();
                if (assetList.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: NoDataScreen(onRetry: _reload),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return AssetManagementListRow(
                      assetModel: assetList[index],
                    );
                  },
                  itemCount: assetList.length,
                );
              },
              error: (error, stackTrace) {
                return Center(
                  child: ErrorScreen(
                      errorMessage: error.toString(), onRetry: _reload),
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
            ),
          ),
        ],
      ),
    );
  }
}
