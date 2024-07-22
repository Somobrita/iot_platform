import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../sensor_data.dart';
import '../sensor_service.dart';

class CustomColumnChart extends StatelessWidget {
  final String selectedMetric;
  final String selectedTime;

  const CustomColumnChart({
    required this.selectedMetric,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    List<SensorData> sensorData;
    List<String> xAxisLabels = [];

    switch (selectedTime) {
      case 'Last 8 hrs':
        sensorData = SensorService.getSensorDataForLast8Hours();
        xAxisLabels = List.generate(8, (index) => '${index + 1} hr');
        break;
      case 'Last 24 hrs':
        sensorData = SensorService.getSensorDataForLast24Hours();
        xAxisLabels = List.generate(12, (index) => '${index + 1} hr');
        break;
      case 'Week':
        sensorData = SensorService.getSensorDataForLastWeek();
        xAxisLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        break;
      case 'Month':
        sensorData = SensorService.getSensorDataForLastMonth();
        xAxisLabels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
        break;
      case 'Last 6 Month':
        sensorData = SensorService.getSensorDataForLast6Months();
        xAxisLabels = ['1', '2', '3', '4', '5', '6'];
        break;
      default:
        sensorData = SensorService.getSensorDataForLast8Hours();
        xAxisLabels = List.generate(8, (index) => '${index + 1} hr');
    }

    List<double> metricValues = [];
    switch (selectedMetric) {
      case 'Temperature':
        metricValues = sensorData.map((data) => data.temperature).toList();
        break;
      case 'Humidity':
        metricValues = sensorData.map((data) => data.humidity).toList();
        break;
      case 'CO2':
        metricValues = sensorData.map((data) => data.co2Level).toList();
        break;
      case 'CO':
        metricValues = sensorData.map((data) => data.coLevel).toList();
        break;
      case 'NO2':
        metricValues = sensorData.map((data) => data.no2Level).toList();
        break;
      case 'SO2':
        metricValues = sensorData.map((data) => data.so2Level).toList();
        break;
      case 'PM 10':
        metricValues = sensorData.map((data) => data.pm10Level).toList();
        break;
      case 'PM 2.5':
        metricValues = sensorData.map((data) => data.pm25Level).toList();
        break;
      case 'O3':
        metricValues = sensorData.map((data) => data.o3Level).toList();
        break;
      case 'Ambient light':
        metricValues = sensorData.map((data) => data.ambientLight).toList();
        break;
      case 'UV intensity':
        metricValues = sensorData.map((data) => data.uvIntensity).toList();
        break;
      case 'Ambient sound':
        metricValues = sensorData.map((data) => data.ambientSound).toList();
        break;
      default:
        metricValues = sensorData.map((data) => data.temperature).toList();
    }

    List<ChartData> chartData = [];
    for (int i = 0; i < metricValues.length && i < xAxisLabels.length; i++) {
      chartData.add(ChartData(xAxisLabels[i], metricValues[i]));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Adjust padding as needed
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          plotAreaBorderWidth: 1, // Remove plot area border
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            majorGridLines: MajorGridLines(width: 1),
            // Adjust the range of x-axis to include a small padding on both ends
            visibleMinimum: -0.5,
            visibleMaximum: xAxisLabels.length - 0.5,
          ), // Use CategoryAxis for vertical bars
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: selectedMetric), // Display selected parameter vertically
            labelRotation: 0, // Set label rotation to 0 for horizontal labels
            axisLine: AxisLine(width: 1), // Hide y-axis line
            majorTickLines: MajorTickLines(size: 1), // Hide y-axis tick marks
          ), // Use NumericAxis for horizontal bars
          tooltipBehavior: TooltipBehavior(
            enable: true, // Enable tooltip
            header: selectedMetric, // Customize tooltip header
            format: 'point.x: point.y', // Customize tooltip content
          ),
          series: <ChartSeries>[
            ColumnSeries<ChartData, String>( // Specify ColumnSeries<ChartData, String> for vertical bars
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              width: 0.5, // Adjust the thickness of the bars
              enableTooltip: true, // Enable tooltip for this series
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
