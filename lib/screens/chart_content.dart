import 'package:flutter/material.dart';
import '../widgets/column_chart_widget.dart';
import '../widgets/spline_chart_widget.dart'; // Import the spline chart widget

class ChartContent extends StatefulWidget {
  @override
  _ChartContentState createState() => _ChartContentState();
}

class _ChartContentState extends State<ChartContent> {
  String _selectedMetric = 'AQI';
  String _selectedTime = 'Last 8 hrs';
  bool _isSplineChart = false; // Track whether to show spline or column chart

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedMetric,
                            items: <String>[
                              'AQI',
                              'PM 2.5',
                              'PM 10',
                              'Temperature',
                              'Humidity',
                              'SO2',
                              'NO2',
                              'CO',
                              'CO2',
                              'O3',
                              'Ambient light',
                              'UV intensity',
                              'Ambient sound',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedMetric = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Add some space between dropdowns
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedTime,
                            items: <String>[
                              'Last 8 hrs',
                              'Last 24 hrs',
                              'Week',
                              'Month',
                              'Last 6 Month'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedTime = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Switch( // Add the switch widget
                    value: _isSplineChart,
                    onChanged: (value) {
                      setState(() {
                        _isSplineChart = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            // color: Colors.grey[200], // Placeholder color for the chart area
            child: Center(
              child: _isSplineChart
                  ? CustomSplineChart(
                selectedTime: _selectedTime,
                selectedMetric: _selectedMetric,
              )
                  : CustomColumnChart(
                selectedTime: _selectedTime,
                selectedMetric: _selectedMetric,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
