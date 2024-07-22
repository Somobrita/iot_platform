import 'dart:convert';

import 'package:asset_tracker/resource/app_resource.dart';
import 'package:asset_tracker/screens/asset_report/graphical_view_screen.dart';
import 'package:asset_tracker/screens/asset_report/tabular_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/asset/asset_model.dart';
import '../../models/asset_report/asset_group_model.dart';
import '../../provider/api_data_provider.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/cancel_button.dart';
import '../../widgets/submit_button.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetTrackReportScreen extends ConsumerStatefulWidget {
  const AssetTrackReportScreen({super.key});

  @override
  ConsumerState<AssetTrackReportScreen> createState() =>
      _AssetTrackReportScreenState();
}

class _AssetTrackReportScreenState extends ConsumerState<AssetTrackReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final DateTime _selectedDate = DateTime.now();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  int _selectedIndex = 0;
  AssetGroupModel? _selectedGroup;
  AssetModel? selectedAsset;
  late Future<List<AssetModel>> _loadedAllAsset;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<List<AssetModel>> _loadAllAsset() async {
    if (_selectedGroup != null) {
      /// Here we getting/fetch data from server
      String zoneUrl =
          '${AppApi.getAssetsByGroupIdApi}${_selectedGroup!.id.toString()}';

      // Create storage
      const storage = FlutterSecureStorage();
      // Read token value
      String? authToken = await storage.read(key: AppDatabase.token);
      print('authToken $authToken');

      final Map<String, String> headers = {
        AppApiKey.contentTypeKey: AppApiKey.contentTypeValue,
        AppApiKey.acceptKey: AppApiKey.acceptValue,
        AppApiKey.authorizationKey: '${AppApiKey.bearer}$authToken'
        // Add other headers as needed, e.g., 'Authorization'
      };
      print('zoneUrl $zoneUrl');
      print('headers $headers');
      final response = await http.get(Uri.parse(zoneUrl), headers: headers);
      print('response.statusCode ${response.statusCode}');
      if (response.statusCode == 200) {
        List responseBody = json.decode(response.body);
        List<AssetModel> areaList =
            responseBody.map((area) => AssetModel.fromJson(area)).toList();
        print('Zone fetch. $responseBody');
        print('Zone fetch List $areaList');
        return areaList;
      } else {
        throw Exception(
            'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
      }
    }

    throw Exception('Failed to fetch data. Please try again later!');
  }

  void _onCancelClick() {
    _formKey.currentState!.reset();
    _startDateController.clear();
    _endDateController.clear();
    _selectedGroup = null;
    selectedAsset = null;
    Navigator.of(context).pop();
  }

  void _onSubmitClick() {
    final isValid = _formKey.currentState!.validate();
    print('Form isValid: $isValid');
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    print('Date: $_selectedDate');
    print('Dropdown selectedGroup: $_selectedGroup');
    print('Dropdown selectedAsset: $selectedAsset');
    _formKey.currentState!.reset();
    _startDateController.clear();
    _endDateController.clear();
    _selectedGroup = null;
    selectedAsset = null;

    Navigator.of(context).pop();
  }

  Future<void> _filterDialog(BuildContext context) {
    final assetGroupData = ref.watch(assetGroupListProvider);
    //AssetGroupModel? selectedValue = ref.watch(assetGroupModelStateProvider);
    //final assetByGroupId = ref.watch(assetByGroupIdProvider(selectedValue?.id));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        'Filter',
        style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      /// In Flutter, the StatefulBuilder widget is often used when you need to
      /// rebuild a part of the UI tree in response to user interactions without
      /// rebuilding the entire widget tree. This can be useful when working with dialogs,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _startDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Choose date',
                        labelText: 'Start date',
                        labelStyle: const TextStyle(fontSize: 18),
                      ),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      validator: (startDate) {
                        if (startDate == null || startDate.isEmpty) {
                          return "Please Input Start Date";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {},
                      onTap: () async {
                        DateTime? startPickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (startPickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(startPickedDate);
                          setState(() {
                            _startDateController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Choose date',
                        labelText: 'End date',
                        labelStyle: const TextStyle(fontSize: 18),
                      ),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      validator: (endDate) {
                        if (endDate == null || endDate.isEmpty) {
                          return "Please Input End Date";
                        } else {
                          return null;
                        }
                      },
                      onTap: () async {
                        if (_startDateController.text.isNotEmpty) {
                          String dateTime = _startDateController.text;
                          DateFormat inputFormat = DateFormat('dd-MM-yyyy');
                          DateTime input = inputFormat.parse(dateTime);

                          DateTime? endPickedDate = await showDatePicker(
                            context: context,
                            initialDate: input.add(const Duration(days: 1)),
                            firstDate: input.add(const Duration(days: 1)),
                            lastDate: DateTime(2100),
                          );
                          if (endPickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(endPickedDate);
                            setState(() {
                              _endDateController.text = formattedDate;
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'You need to select Start Date',
                                style: GoogleFonts.latoTextTheme()
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.onBackground,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    assetGroupData.when(
                      data: (data) {
                        List<AssetGroupModel> assetList =
                            data.map((e) => e).toList();
                        if (assetList.isEmpty) {
                          return Container(
                            alignment: Alignment.center,
                            child: const Text('No data found'),
                          );
                        }
                        return DropdownButtonFormField<AssetGroupModel>(
                          //hint: const Text("Select Area"),
                          isExpanded: true,
                          value: _selectedGroup,
                          decoration: InputDecoration(
                            labelText: 'Select group',
                            hintText: 'Please choose group',
                            labelStyle: const TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                gapPadding: 5),
                          ),
                          onChanged: (AssetGroupModel? value) {
                            //ref.invalidate(assetByGroupIdProvider);
                            //ref.read(assetByGroupIdProvider(value?.id));

                            //ref.read(assetGroupModelStateProvider.notifier).state = value;
                            //ref.read(assetModelStateProvider.notifier).state = null;

                            _formKey.currentState!.validate();
                            setState(() {
                              _selectedGroup = value;
                              selectedAsset = null;
                              _loadedAllAsset = _loadAllAsset();
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Please select group";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {},
                          items: assetList
                              .map(
                                (AssetGroupModel cate) =>
                                    DropdownMenuItem<AssetGroupModel>(
                                  value: cate,
                                  child: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 20,
                                          // Adjust the radius as needed
                                          //backgroundImage: NetworkImage(cate.image!),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(cate.groupName,
                                          style: GoogleFonts.latoTextTheme()
                                              .titleLarge!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground))
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                      error: (error, stackTrace) {
                        return Text(error.toString());
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
                    const SizedBox(height: 10),
                    if (_selectedGroup != null)
                      FutureBuilder(
                        future: _loadedAllAsset,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.blueAccent,
                                size: 70,
                              ),
                            );
                          }
                          if (snapshot.data!.isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              child: const Text('No data found'),
                            );
                          }
                          return DropdownButtonFormField<AssetModel>(
                            //hint: const Text("Select Area"),
                            isExpanded: true,
                            value: selectedAsset,
                            decoration: InputDecoration(
                              labelText: 'Select asset',
                              hintText: 'Please choose asset',
                              labelStyle: const TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  gapPadding: 5),
                            ),
                            onChanged: (AssetModel? value) {
                              _formKey.currentState!.validate();
                              setState(() {
                                selectedAsset = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Please select asset";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (newValue) {},
                            items: snapshot.data!
                                .map(
                                  (AssetModel cate) =>
                                      DropdownMenuItem<AssetModel>(
                                    value: cate,
                                    child: Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            cate.name!,
                                            style: GoogleFonts.latoTextTheme()
                                                .titleLarge!
                                                .copyWith(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        CancelButton(
          cancelText: AppTexts.cancel,
          onCancelClick: _onCancelClick,
        ),
        SubmitButton(
          submitText: AppTexts.search,
          onSubmitClick: _onSubmitClick,
        ),
      ],
    );

    // show the dialog
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const SizedBox.expand(child: FlutterLogo()),
        );
      },
      transitionBuilder: (ctx, anim, a2, child) {
        var curve = Curves.easeInOut.transform(anim.value);
        return Transform.scale(
          scale: curve,
          filterQuality: FilterQuality.medium,
          child: alert,
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: false,
      barrierLabel: "Barrier",
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  @override
  void initState() {
    super.initState();
    ref.read(assetGroupListProvider);
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constants.assetTrackReport,
          style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            onPressed: () {
              _filterDialog(context);
            },
            icon: const Icon(
              Icons.filter_alt,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Utils().downloadFileDialog(context,
                  'https://iotace.mindteck.com/53ab00f5-3d8c-4050-ac36-b70c6e7f1939');
            },
            icon: const Icon(
              Icons.cloud_download_outlined,
              color: Colors.white,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
            controller: _controller,
            indicatorColor: Colors.amberAccent,
            indicatorSize: TabBarIndicatorSize.label,
            padding: EdgeInsets.zero,
            isScrollable: false,
            indicatorWeight: 5,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30), // Creates border
              color: Colors.greenAccent,
            ),
            onTap: (index) {
              _controller.animateTo(_selectedIndex += 1);
            },
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.list,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8), // Adjust the spacing here
                    Text(
                      Constants.tabularView,
                      style:
                          GoogleFonts.latoTextTheme().headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.auto_graph_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8), // Adjust the spacing here
                    Text(
                      Constants.graphicalView,
                      style:
                          GoogleFonts.latoTextTheme().headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                    ),
                  ],
                ),
                /*icon: const Icon(
                  Icons.auto_graph_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                child: Text(
                  Constants.graphicalView,
                  style: GoogleFonts.latoTextTheme().headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),*/
              )
            ],
          ),
        ),
      ),

      /// WillPopScope is a widget in the Flutter framework, which is used for
      /// controlling the behavior of the back button or the system navigation
      /// gestures on Android devices. It allows you to intercept and handle
      /// the back button press event to perform custom actions
      ///
      body: TabBarView(
        controller: _controller,
        children: const [
          TabularViewScreen(),
          GraphicalViewScreen(),
        ],
      ),
    );
  }
}
