import 'package:asset_tracker/utils/constants.dart';
import 'package:asset_tracker/widgets/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class MainDrawer extends StatelessWidget {
  const MainDrawer(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.onSelect});

  final void Function(String identifier) onSelect;
  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            color: Theme.of(context).colorScheme.secondaryContainer,
            // Background color for the header
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16, top: 35),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary, // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40, // Adjust the radius as needed
                    backgroundImage:
                        const NetworkImage('https://example.com/avatar.png'),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userName,
                  style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 18,
                      ),
                ),
                Text(
                  userEmail,
                  style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 13,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MenuItems(
                    textSize: 18,
                    iconSize: 20,
                    menuName: Constants.dashBoard,
                    menuImg: Icons.dashboard_outlined,
                    onMenuItemClick: onSelect),
                /*MenuItems(
                    textSize: 18,
                    iconSize: 20,
                    menuName: Constants.userManagement,
                    menuImg: Icons.settings,
                    onMenuItemClick: onSelect),*/
                MenuItems(
                  textSize: 18,
                  iconSize: 20,
                  menuName: Constants.areaManagement,
                  menuImg: Icons.home_outlined,
                  onMenuItemClick: onSelect,
                ),
                MenuItems(
                  textSize: 18,
                  iconSize: 20,
                  menuName: Constants.zoneManagement,
                  menuImg: Icons.location_on_outlined,
                  onMenuItemClick: onSelect,
                ),
                MenuItems(
                  textSize: 18,
                  iconSize: 20,
                  menuName: Constants.assetManagement,
                  menuImg: Icons.assessment_outlined,
                  onMenuItemClick: onSelect,
                ),
                MenuItems(
                  textSize: 18,
                  iconSize: 20,
                  menuName: Constants.assetTrackReport,
                  menuImg: Icons.report_outlined,
                  onMenuItemClick: onSelect,
                ),
                MenuItems(
                  textSize: 18,
                  iconSize: 20,
                  menuName: Constants.locateAsset,
                  menuImg: Icons.web_asset,
                  onMenuItemClick: onSelect,
                ),
                MenuItems(
                  textSize: 18,
                  iconSize: 20,
                  menuName: Constants.alarms,
                  menuImg: Icons.alarm,
                  onMenuItemClick: onSelect,
                ),
                /*ExpansionTile(
                  leading: const Icon(
                    Icons.dashboard_outlined,
                    size: 20,
                  ),
                  title: Text(
                    Constants.iotCore,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18,
                        ),
                  ),
                  children: [
                    MenuItems(
                        textSize: 15,
                        iconSize: 18,
                        menuName: Constants.deviceManagement,
                        menuImg: Icons.devices,
                        onMenuItemClick: onSelect),
                    MenuItems(
                        textSize: 15,
                        iconSize: 18,
                        menuName: Constants.serviceManagement,
                        menuImg: Icons.home_repair_service_rounded,
                        onMenuItemClick: onSelect),
                  ],
                ),*/
                /*Expanded(
                  child: ExpansionTile(
                    leading: const Icon(
                      Icons.dashboard_outlined,
                      size: 20,
                    ),
                    title: Text(
                      Constants.assetTracking,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 18,
                          ),
                    ),
                    children: [
                      MenuItems(
                        textSize: 15,
                        iconSize: 18,
                        menuName: Constants.areaManagement,
                        menuImg: Icons.home_outlined,
                        onMenuItemClick: onSelect,
                      ),
                      MenuItems(
                        textSize: 15,
                        iconSize: 18,
                        menuName: Constants.zoneManagement,
                        menuImg: Icons.location_on_outlined,
                        onMenuItemClick: onSelect,
                      ),
                      MenuItems(
                        textSize: 15,
                        iconSize: 18,
                        menuName: Constants.assetManagement,
                        menuImg: Icons.assessment_outlined,
                        onMenuItemClick: onSelect,
                      ),
                      MenuItems(
                        textSize: 15,
                        iconSize: 18,
                        menuName: Constants.assetTrackReport,
                        menuImg: Icons.report_outlined,
                        onMenuItemClick: onSelect,
                      ),
                      MenuItems(
                        textSize: 15,
                        iconSize: 18,
                        menuName: Constants.locateAsset,
                        menuImg: Icons.web_asset,
                        onMenuItemClick: onSelect,
                      ),
                      MenuItems(
                        textSize: 15,
                        iconSize: 18,
                        menuName: Constants.alarms,
                        menuImg: Icons.alarm,
                        onMenuItemClick: onSelect,
                      ),
                    ],
                  ),
                )*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
