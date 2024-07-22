import 'package:asset_tracker/models/zone/zone_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resource/app_resource.dart';
import '../screens/full_screen_image.dart';
import '../utils/arc_clipper.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ZoneManagementListRow extends StatelessWidget {
  const ZoneManagementListRow({super.key, required this.zoneModel});

  final ZoneModel zoneModel;

  @override
  Widget build(BuildContext context) {
    print('ZoneManagementListRow build');

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(5.0),
        ),
      ),
      elevation: 5,
      color: Theme.of(context).colorScheme.surfaceVariant,
      // Set the clip behavior of the card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.zero,
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(20.0)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(.5),
                    Theme.of(context).colorScheme.onPrimaryContainer,
                  ],
                ),
              ),
              child: ClipRect(child: CustomPaint(painter: ArcClipper())),
            ),
          ),
          InkWell(
            highlightColor: Colors.blue.withOpacity(0.4),
            splashColor: Colors.green.withOpacity(0.5),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    print(zoneModel.area!.layoutImageUrl!);
                    if (zoneModel.area!.layoutImageUrl!.isEmpty ||
                        zoneModel.area!.layoutImageUrl == null) {
                      return FullScreenPage(
                        dark: true,
                        child: Image.asset(
                            'assets/images/no-image-icon-23504.png'),
                      );
                    }
                    return FullScreenPage(
                      dark: true,
                      child: Image.network(
                        zoneModel.area!.layoutImageUrl!,
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = 0.0;
                    var end = 1.0;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return ScaleTransition(
                      scale: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (zoneModel.area!.layoutImageUrl!.isEmpty ||
                      zoneModel.area!.layoutImageUrl == null)
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black12, Colors.white10],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Image.asset(
                        'assets/images/no-image-icon-23504.png',
                        width: double.infinity,
                        height: 80,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    )
                  else
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black12, Colors.white10],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Image.network(
                        zoneModel.area!.layoutImageUrl!,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        scale: 1,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      zoneModel.name!,
                      style: GoogleFonts.latoTextTheme().titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.background,
                            fontSize: 15,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),

                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      zoneModel.zoneTypeName!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.normal),
                    ),

                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      // Format the datetime as needed
                      zoneModel.area!.name!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.normal),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
