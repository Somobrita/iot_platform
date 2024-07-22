import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LinearGaugeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        height: 70,
        child: Stack(
          children: [
            // Linear Gauge
            SfLinearGauge(
              minimum: 0,
              maximum: 500,
              axisTrackStyle: const LinearAxisTrackStyle(
                thickness: 5, // Increased thickness
              ),
              majorTickStyle: const LinearTickStyle(
                length: 10,
                thickness: 2, // Increased thickness
                color: Colors.black,
              ),
              ranges: const <LinearGaugeRange>[
                LinearGaugeRange(
                  startValue: 0,
                  endValue: 50,
                  color: Colors.green,
                ),
                LinearGaugeRange(
                  startValue: 51,
                  endValue: 100,
                  color: Colors.yellow,
                ),
                LinearGaugeRange(
                  startValue: 101,
                  endValue: 200,
                  color: Colors.orange,
                ),
                LinearGaugeRange(
                  startValue: 201,
                  endValue: 300,
                  color: Colors.red,
                ),
                LinearGaugeRange(
                  startValue: 301,
                  endValue: 400,
                  color: Colors.blue,
                ),
                LinearGaugeRange(
                  startValue: 401,
                  endValue: 500,
                  color: Colors.purple,
                ),
              ],
            ),
            // Labels
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Good', style: TextStyle(fontSize: 12)),
                  Text('Bad', style: TextStyle(fontSize: 12)),
                  Text('Poor', style: TextStyle(fontSize: 12)),
                  Text('Unhealthy', style: TextStyle(fontSize: 12)),
                  Text('Severe', style: TextStyle(fontSize: 12)),
                  Text('Hazardous', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
