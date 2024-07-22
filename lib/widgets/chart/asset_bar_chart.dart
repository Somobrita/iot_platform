import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class AssetBarChart extends StatefulWidget {
  const AssetBarChart({super.key});

  @override
  State<AssetBarChart> createState() => _AssetBarChartState();
}

// Define data structure for a bar group
class DataItem {
  int x;
  double y1;
  double y2;
  double y3;

  DataItem(
      {required this.x, required this.y1, required this.y2, required this.y3});
}

class _AssetBarChartState extends State<AssetBarChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(
            show: true,
            border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide(width: 2),
              bottom: BorderSide(width: 1),
            ),
          ),
          groupsSpace: 10,
          barGroups: [
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 10,
                  width: 15,
                  color: Colors.deepPurple,
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 10,
                  width: 15,
                  color: Colors.amber,
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 15,
                  width: 15,
                  color: Colors.deepPurple,
                ),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 10,
                  width: 15,
                  color: Colors.amber,
                ),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 11,
                  width: 15,
                  color: Colors.deepPurple,
                ),
              ],
            ),
            BarChartGroupData(
              x: 6,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 10,
                  width: 15,
                  color: Colors.amber,
                ),
              ],
            ),
            BarChartGroupData(
              x: 7,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 10,
                  width: 15,
                  color: Colors.deepPurple,
                ),
              ],
            ),
            BarChartGroupData(
              x: 8,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 10,
                  width: 15,
                  color: Colors.amber,
                ),
              ],
            ),
          ],
        ),
        swapAnimationDuration: const Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear,
      ),
    );
  }
}
