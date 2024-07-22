import 'package:asset_tracker/models/area/area_model.dart';
import 'package:flutter/material.dart';

import '../screens/full_screen_image.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AreaManagementListRow extends StatelessWidget {
  const AreaManagementListRow({super.key, required this.areaModel});

  final AreaModel areaModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(.9),
      margin: const EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          backgroundImage: NetworkImage(areaModel.layoutImageUrl!),
        ),
        title: Text(
          areaModel.name!,
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
            fontWeight: FontWeight.bold,
          ),
        ),
        //trailing: Icon(Icons.assessment),
        onTap: () {
          // Handle row tap here
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                print(areaModel.layoutImageUrl!);
                if (areaModel.layoutImageUrl!.isEmpty ||
                    areaModel.layoutImageUrl == null) {
                  return FullScreenPage(
                    dark: true,
                    child: Image.asset('assets/images/no-image-icon-23504.png'),
                  );
                }
                return FullScreenPage(
                  dark: true,
                  child: Image.network(
                    areaModel.layoutImageUrl!,
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
      ),
    );
  }
}
