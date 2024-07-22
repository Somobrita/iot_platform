import 'package:asset_tracker/screens/locate/area_layout_screen.dart';
import 'package:asset_tracker/screens/locate/track_area_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class LocateAssetScreen extends StatefulWidget {
  const LocateAssetScreen({super.key});

  @override
  State<LocateAssetScreen> createState() => _LocateAssetScreenState();
}

class _LocateAssetScreenState extends State<LocateAssetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Constants.locateAsset,
            style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              controller: _controller,
              indicatorColor: Colors.amberAccent,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: false,
              indicatorWeight: 5,
              padding: EdgeInsets.zero,
              automaticIndicatorColorAdjustment: true,
              /*indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(100), // Creates border
                color: Colors.greenAccent,
              ),*/
              onTap: (index) {
                _controller.animateTo(_selectedIndex += 1);
              },
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8), // Adjust the spacing here
                      Text(
                        Constants.areaLayout,
                        style: GoogleFonts.latoTextTheme()
                            .headlineMedium!
                            .copyWith(
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
                        Icons.ad_units_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8), // Adjust the spacing here
                      Text(
                        Constants.trackAsset,
                        style: GoogleFonts.latoTextTheme()
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
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
            AreaLayoutScreen(),
            TrackAreaScreen(),
          ],
        ),
      ),
    );
  }
}
