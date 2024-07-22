import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../sensor_data.dart';
import '../sensor_service.dart';

class CustomSplineChart extends StatelessWidget {
  final String selectedMetric;
  final String selectedTime;

  const CustomSplineChart({
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
        // Reduce data points to 1 per day
        sensorData = _reduceDataToDaily(sensorData);
        break;
      case 'Month':
        sensorData = SensorService.getSensorDataForLastMonth();
        xAxisLabels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
        // Reduce data points to 1 per week
        sensorData = _reduceDataToWeekly(sensorData);
        break;
      case 'Last 6 Month':
        sensorData = SensorService.getSensorDataForLast6Months();
        xAxisLabels = ['1', '2', '3', '4', '5', '6'];
        // Reduce data points to 1 per month
        sensorData = _reduceDataToMonthly(sensorData);
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
    for (int i = 0; i < metricValues.length; i++) {
      chartData.add(ChartData(i.toDouble(), metricValues[i]));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Adjust padding as needed
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            majorGridLines: MajorGridLines(width: 1),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: selectedMetric),
            labelRotation: 0,
            axisLine: AxisLine(width: 1),
            majorTickLines: MajorTickLines(size: 5),
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true, // Enable tooltip
            header: selectedMetric, // Customize tooltip header
            format: 'point.x: point.y', // Customize tooltip content
          ),
          series: <ChartSeries>[
            SplineSeries<ChartData, double>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              name: selectedMetric,
              enableTooltip: true, // Enable tooltip for this series
            ),
          ],
        ),
      ),
    );
  }

  List<SensorData> _reduceDataToDaily(List<SensorData> data) {
    List<SensorData> reducedData = [];
    for (int i = 0; i < data.length; i += 7) {
      reducedData.add(data[i]);
    }
    return reducedData;
  }

  List<SensorData> _reduceDataToWeekly(List<SensorData> data) {
    List<SensorData> reducedData = [];
    for (int i = 0; i < data.length; i += 4) {
      reducedData.add(data[i]);
    }
    return reducedData;
  }

  List<SensorData> _reduceDataToMonthly(List<SensorData> data) {
    List<SensorData> reducedData = [];
    for (int i = 0; i < data.length; i += 30) {
      reducedData.add(data[i]);
    }
    return reducedData;
  }
}

class ChartData {
  final double x;
  final double y;

  ChartData(this.x, this.y);

  static List<String> labels(List<ChartData> chartData) {
    return chartData.map((data) => '${data.x}').toList();
  }
}
