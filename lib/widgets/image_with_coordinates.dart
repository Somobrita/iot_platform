import 'dart:math';

import 'package:asset_tracker/models/locate/map_point.dart';
import 'package:asset_tracker/models/locate/zone_area.dart';
import 'package:flutter/material.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class ImagePainter extends CustomPainter {
  const ImagePainter(
      {required this.screenSize,
      required this.imageUrl,
      required this.points,
      required this.zoneAreas});

  final List<MapPoint> points;
  final ZoneAreas zoneAreas;
  final String imageUrl;
  final Size screenSize;

  @override
  void paint(Canvas canvas, Size size) {
    // Load an image (you can replace this with your own image)
    final image = Image.network(
      imageUrl,
      fit: BoxFit.fill,
    );
    final imageProvider = image.image.resolve(const ImageConfiguration());
// Define the vertices to create the polygon, adjusted for screen size
    final polygonVertices = [
      Point(screenSize.width * 0.1, screenSize.height * 0.1),
      Point(screenSize.width * 0.3, screenSize.height * 0.3),
      Point(screenSize.width * 0.2, screenSize.height * 0.2),
      // Add more points to define your polygon
    ];
    imageProvider.addListener(
      ImageStreamListener((info, call) {
        final rect = Offset(0, 0) & screenSize;
        final paint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill
          ..strokeWidth = 2.0;

        // Draw the image
        //canvas.drawImage(info.image, Offset(0, 0), paint);
        canvas.drawImageRect(info.image, rect, rect, paint);

        // Define a list of x and y coordinates
        /*final coordinates = [Offset(50, 50),
          Offset(80, 70),
          Offset(380, 175),
          Offset(200, 175),
          Offset(150, 105),
          Offset(300, 75),
          Offset(320, 200),
          Offset(89, 125)];*/

        final coordinates = [];

        points.forEach((element) {
          coordinates.add(Offset(element.x! / 10.0, element.y! / 10.0));
        });

        final radius = 5.0; // Adjust the size of the points

        // Plot points at specified coordinates
        for (final coordinate in coordinates) {
          //canvas.drawCircle(coordinate, radius, paint);
        }

        final path = Path();
        path.moveTo(polygonVertices.first.x, polygonVertices.first.y);

        for (var point in coordinates) {
          path.lineTo(point.dx, point.dy);
        }

        path.close();
        canvas.drawPath(path, paint);

        // You can add more coordinates or graphics as needed
      }),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
