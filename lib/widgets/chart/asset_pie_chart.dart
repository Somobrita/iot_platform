import 'dart:convert';

import 'package:asset_tracker/models/dashboard/pie_chart_model.dart';
import 'package:asset_tracker/resource/app_resource.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../error_screen.dart';
import '../indicator.dart';
import '../no_data_screen.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetPieChart extends StatefulWidget {
  const AssetPieChart({super.key});

  @override
  State<StatefulWidget> createState() => _AssetPieChartState();
}

class _AssetPieChartState extends State {
  int touchedIndex = -1;
  double firstDegree = 80;
  double secondDegree = 80;
  double thirdDegree = 80;
  double forthDegree = 80;
  late Future<List<PieChartModel>> _loadedItems;

  Future<List<PieChartModel>> _loadPieChartData() async {
    /// Here we getting/fetch data from server
    const String zoneUrl = AppApi.getAllAssetByTypeApi;

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
      List<PieChartModel> areaList =
          responseBody.map((area) => PieChartModel.fromJson(area)).toList();
      print('Zone fetch. $responseBody');
      print('Zone fetch List $areaList');
      return areaList;
    } else {
      throw Exception(
          'Failed to fetch data. Please try again later! ${response.reasonPhrase}');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadPieChartData();
  }

  @override
  Widget build(BuildContext context) {
    if (touchedIndex != -1) {
      print('touchedIndex $touchedIndex');
      if (touchedIndex == 0) {
        if (firstDegree == 80) {
          firstDegree = 100;
        } else {
          firstDegree = 80;
        }
      } else if (touchedIndex == 1) {
        if (secondDegree == 80) {
          secondDegree = 100;
        } else {
          secondDegree = 80;
        }
      } else if (touchedIndex == 2) {
        if (thirdDegree == 80) {
          thirdDegree = 100;
        } else {
          thirdDegree = 80;
        }
      } else if (touchedIndex == 3) {
        if (forthDegree == 80) {
          forthDegree = 100;
        } else {
          forthDegree = 80;
        }
      }
    }
    return FutureBuilder(
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
                errorMessage: snapshot.error.toString(), onRetry: () {}),
          );
        }

        if (snapshot.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: NoDataScreen(onRetry: () {}),
          );
        }
        return AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                            //startDegree = 270.0;
                          });
                        },
                        enabled: true,
                      ),
                      centerSpaceRadius: 20,
                      //startDegreeOffset: startDegree,
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      sections: [
                        PieChartSectionData(
                          value: snapshot.data![0].assetCount.toDouble(),
                          color: AppColors.contentColorBlue,
                          radius: firstDegree,
                          showTitle: true,
                          title: snapshot.data![0].assetCount.toString(),
                          titleStyle: GoogleFonts.latoTextTheme()
                              .titleSmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                        ),
                        PieChartSectionData(
                          value: snapshot.data![1].assetCount.toDouble(),
                          color: AppColors.contentColorYellow,
                          radius: secondDegree,
                          showTitle: true,
                          title: snapshot.data![1].assetCount.toString(),
                          titleStyle: GoogleFonts.latoTextTheme()
                              .titleSmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                        ),
                        PieChartSectionData(
                          value: snapshot.data![2].assetCount.toDouble(),
                          color: AppColors.contentColorPink,
                          radius: thirdDegree,
                          showTitle: true,
                          title: snapshot.data![2].assetCount.toString(),
                          titleStyle: GoogleFonts.latoTextTheme()
                              .titleSmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                        ),
                        PieChartSectionData(
                          value: snapshot.data![3].assetCount.toDouble(),
                          color: AppColors.contentColorGreen,
                          radius: forthDegree,
                          showTitle: true,
                          title: snapshot.data![3].assetCount.toString(),
                          titleStyle: GoogleFonts.latoTextTheme()
                              .titleSmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                        ),
                      ],
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 150),
                    // Optional
                    swapAnimationCurve: Curves.linear,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: AppColors.contentColorBlue,
                    text: snapshot.data![0].assetType,
                    isSquare: false,
                    textColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: AppColors.contentColorYellow,
                    text: snapshot.data![1].assetType,
                    isSquare: false,
                    textColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: AppColors.contentColorPink,
                    text: snapshot.data![2].assetType,
                    isSquare: false,
                    textColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: AppColors.contentColorGreen,
                    text: snapshot.data![3].assetType,
                    isSquare: false,
                    textColor: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
