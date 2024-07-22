import 'package:asset_tracker/models/zone/zone_model.dart';
import 'package:asset_tracker/provider/api_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_search_delegate.dart';
import '../../widgets/error_screen.dart';
import '../../widgets/no_data_screen.dart';
import '../../widgets/zone_management_list_row.dart';
import 'add_zone_screen.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ZoneManagementScreen extends ConsumerStatefulWidget {
  const ZoneManagementScreen({super.key});

  @override
  ConsumerState<ZoneManagementScreen> createState() =>
      _ZoneManagementScreenState();
}

class _ZoneManagementScreenState extends ConsumerState<ZoneManagementScreen> {
  void _reload() {
    ref.invalidate(zoneListProvider);
    ref.read(zoneListProvider);
  }

  void _addNewZone() async {
    final isAdded = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (context) {
        return const AddZoneScreen();
      },
    ));

    if (isAdded!) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Zone add feature available soon!',
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
    ref.read(zoneListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final zoneData = ref.watch(zoneListProvider);
    return Scaffold(
      /// WillPopScope is a widget in the Flutter framework, which is used for
      /// controlling the behavior of the back button or the system navigation
      /// gestures on Android devices. It allows you to intercept and handle
      /// the back button press event to perform custom actions
      ///
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            forceElevated: true,
            elevation: 4,
            floating: true,
            snap: true,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Text(
              Constants.zoneManagement,
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
                  zoneData.when(
                    data: (data) {
                      List<ZoneModel> zoneList = data.map((e) => e).toList();
                      return showSearch(
                        context: context,
                        delegate: CustomSearchDelegate<ZoneModel>(
                            optionName: Constants.zoneManagement,
                            searchList: zoneList),
                      );
                    },
                    error: (error, stackTrace) {},
                    loading: () {},
                  );
                },
              ),
              IconButton(
                onPressed: _addNewZone,
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
            child: zoneData.when(
              data: (data) {
                List<ZoneModel> zoneList = data.map((e) => e).toList();
                if (zoneList.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: NoDataScreen(onRetry: _reload),
                  );
                }
                return GridView.count(
                  crossAxisCount: 2,
                  primary: true,
                  padding: const EdgeInsets.all(5),
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1,
                  // Number of columns
                  children: List.generate(zoneList.length, (index) {
                    return ZoneManagementListRow(
                      zoneModel: zoneList[index],
                    );
                  }),
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
