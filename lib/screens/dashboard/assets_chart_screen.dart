import 'package:asset_tracker/widgets/chart/asset_bar_chart.dart';
import 'package:asset_tracker/widgets/chart/asset_pie_chart.dart';
import 'package:flutter/material.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetsChartScreen extends StatefulWidget {
  const AssetsChartScreen({super.key});

  @override
  State<AssetsChartScreen> createState() => _AssetsChartScreenState();
}

class _AssetsChartScreenState extends State<AssetsChartScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // Add the observer in the widget's initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // Don't forget to remove the observer in the widget's dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Implement the didChangeAppLifecycleState method
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('User state: $state');
    if (state == AppLifecycleState.resumed) {
      // This code will be executed when the app is resumed
      // Implement your "OnResume" functionality here
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AssetPieChart(),
              SizedBox(height: 20,),
              AssetBarChart()

              /*SizedBox(
                height: MediaQuery.of(context).size.height /
                    2.5, // Also Including Tab-bar height.
                child: const AssetPieChart(),
              ),
              Container(
                height: 20, // Also Including Tab-bar height.
              ),
              const PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AssetBarChart(),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
