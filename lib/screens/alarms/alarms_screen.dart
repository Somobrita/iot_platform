import 'package:asset_tracker/models/alarm/alarm_model.dart';
import 'package:asset_tracker/provider/api_data_provider.dart';
import 'package:asset_tracker/utils/utils.dart';
import 'package:asset_tracker/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_search_delegate.dart';
import '../../widgets/no_data_screen.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AlarmsScreen extends ConsumerStatefulWidget {
  const AlarmsScreen({super.key});

  @override
  ConsumerState<AlarmsScreen> createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends ConsumerState<AlarmsScreen> {
  void _reload() {
    ref.invalidate(alarmListProvider);
    ref.read(alarmListProvider);
  }

  @override
  void initState() {
    super.initState();
    ref.read(alarmListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final alarmData = ref.watch(alarmListProvider);
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
              Constants.alarms,
              style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  alarmData.when(
                    data: (data) {
                      List<AlarmModel> alarmList = data.map((e) => e).toList();
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate<AlarmModel>(
                            optionName: Constants.alarms,
                            searchList: alarmList),
                      );
                    },
                    error: (error, stackTrace) {},
                    loading: () {},
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  Utils().downloadFileDialog(context,
                      'https://iotace.mindteck.com/53ab00f5-3d8c-4050-ac36-b70c6e7f1939');
                },
                icon: Icon(
                  Icons.cloud_download_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: _reload,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SliverFillRemaining(
            child: alarmData.when(
              data: (data) {
                List<AlarmModel> alarmList = data.map((e) => e).toList();
                if (alarmList.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: NoDataScreen(onRetry: _reload),
                  );
                }
                return const Card(
                  child: Text(Constants.userManagement),
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
            /*child: FutureBuilder(
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
                    child: Center(
                      child: ErrorScreen(
                          errorMessage: snapshot.error.toString(),
                          onRetry: _reload),
                    ),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: NoDataScreen(onRetry: _reload),
                  );
                }
                return const Card(
                  child: Text(Constants.userManagement),
                );
              },
            ),*/
          ),
        ],
      ),
    );
  }
}
