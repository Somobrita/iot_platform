import 'package:asset_tracker/models/area/area_model.dart';
import 'package:asset_tracker/provider/api_data_provider.dart';
import 'package:asset_tracker/screens/area/add_area_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/constants.dart';
import '../../widgets/area_management_list_row.dart';
import '../../widgets/custom_search_delegate.dart';
import '../../widgets/error_screen.dart';
import '../../widgets/no_data_screen.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AreaManagementScreen extends ConsumerStatefulWidget {
  const AreaManagementScreen({super.key});

  @override
  ConsumerState<AreaManagementScreen> createState() =>
      _AreaManagementScreenState();
}

class _AreaManagementScreenState extends ConsumerState<AreaManagementScreen> {
  void _reload() {
    ref.invalidate(areaListProvider);
    ref.read(areaListProvider);
  }

  void _addNewArea() async {
    final isAdded = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (context) {
        return const AddAreaScreen();
      },
    ));

    if (isAdded!) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Area add feature available soon!',
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
    ref.read(areaListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final areaData = ref.watch(areaListProvider);
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
              Constants.areaManagement,
              style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
            actions: [
              /* IconButton(
                  icon: Icon(
                    Icons.filter_list,
                  ),
                  onPressed: () {
                    showFilterDialog(context);
                  },
                ),*/
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  areaData.when(
                    data: (data) {
                      List<AreaModel> areaList = data.map((e) => e).toList();
                      return showSearch(
                        context: context,
                        delegate: CustomSearchDelegate<AreaModel>(
                            optionName: Constants.areaManagement,
                            searchList: areaList),
                      );
                    },
                    error: (error, stackTrace) {},
                    loading: () {},
                  );
                },
              ),
              IconButton(
                onPressed: _addNewArea,
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
            child: areaData.when(
              data: (data) {
                List<AreaModel> areaList = data.map((e) => e).toList();
                if (areaList.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: NoDataScreen(onRetry: _reload),
                  );
                }
                return GridView.count(
                  crossAxisCount: 2,
                  primary: true,
                  padding: const EdgeInsets.all(0.0),
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 3,
                  // Number of columns
                  children: List.generate(areaList.length, (index) {
                    return Center(
                      child: AreaManagementListRow(
                        areaModel: areaList[index],
                      ),
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
