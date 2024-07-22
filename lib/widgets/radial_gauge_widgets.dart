import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGaugeWidget extends StatelessWidget {
  final int aqi;

  const RadialGaugeWidget({required this.aqi});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.25,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 500,
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 50,
                    color: Colors.green,
                    startWidth: 10,
                    endWidth: 10,
                  ),
                  GaugeRange(
                    startValue: 50,
                    endValue: 100,
                    color: Colors.yellow,
                    startWidth: 10,
                    endWidth: 10,
                  ),
                  GaugeRange(
                    startValue: 100,
                    endValue: 150,
                    color: Colors.orange,
                    startWidth: 10,
                    endWidth: 10,
                  ),
                  GaugeRange(
                    startValue: 150,
                    endValue: 200,
                    color: Colors.red,
                    startWidth: 10,
                    endWidth: 10,
                  ),
                  GaugeRange(
                    startValue: 200,
                    endValue: 300,
                    color: Colors.purple,
                    startWidth: 10,
                    endWidth: 10,
                  ),
                  GaugeRange(
                    startValue: 300,
                    endValue: 500,
                    color: Colors.brown,
                    startWidth: 10,
                    endWidth: 10,
                  ),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    value: aqi.toDouble(),
                    enableAnimation: true,
                    needleLength: 0.5, // Adjust needle length
                    lengthUnit: GaugeSizeUnit.factor,
                    needleStartWidth: 1, // Adjust start width
                    needleEndWidth: 3, // Adjust end width
                    knobStyle: KnobStyle(knobRadius: 0.08),
                    tailStyle: TailStyle(
                      width: 5,
                      length: 0.5,
                      color: Colors.blueGrey[900],
                    ),
                    needleColor: Colors.blueGrey[900],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 5), // Adjust spacing as needed
        Text(
          'AQI: $aqi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
