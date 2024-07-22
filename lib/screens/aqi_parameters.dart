import 'package:environmental_monitoring_app/sensor_data.dart';
import 'package:environmental_monitoring_app/sensor_service.dart';
import 'package:flutter/material.dart';

class AQIParameters extends StatefulWidget {
  final List<SensorData> sensorDataList; // Add this parameter

  AQIParameters({required this.sensorDataList}); // Constructor with the parameter

  @override
  _AQIParametersState createState() => _AQIParametersState();
}

class _AQIParametersState extends State<AQIParameters> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<SensorData> _sensorDataList = [];
  // int _aqi = 0;



  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.forward();
    _updateSensorData();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  // Function to update sensor data
  void _updateSensorData() {
    // Get sensor data for the last 24 hours
    _sensorDataList = SensorService.getSensorDataForLast24Hours();
  }

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildParameterCard(
                icon: Icons.air,
                label: 'PM2.5',
                value: _sensorDataList.first.pm25Level,
                unit: 'µg/m³',
                progressValue: _sensorDataList.first.pm25Level,
                color: Colors.orange,
              ),
              _buildParameterCard(
                icon: Icons.air_outlined,
                label: 'PM10',
                value: _sensorDataList.first.pm10Level,
                unit: 'µg/m³',
                progressValue: _sensorDataList.first.pm10Level,
                color: Colors.orange,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildParameterCard(
                icon: Icons.gas_meter,
                label: 'CO',
                value: _sensorDataList.first.coLevel,
                unit: 'ppm',
                progressValue: _sensorDataList.first.coLevel,
                color: Colors.green,
              ),
              _buildParameterCard(
                icon: Icons.gas_meter_outlined,
                label: 'NO2',
                value: _sensorDataList.first.no2Level,
                unit: 'ppb',
                progressValue: _sensorDataList.first.no2Level,
                color: Colors.green,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildParameterCard(
                icon: Icons.cloud,
                label: 'O3',
                value: _sensorDataList.first.o3Level,
                unit: 'ppb',
                progressValue: _sensorDataList.first.o3Level,
                color: Colors.green,
              ),
              _buildParameterCard(
                icon: Icons.cloud,
                label: 'SO2',
                value: _sensorDataList.first.so2Level,
                unit: 'ppb',
                progressValue: _sensorDataList.first.so2Level,
                color: Colors.green,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildParameterCard(
                icon: Icons.heat_pump_rounded,
                label: 'Temperature',
                value: _sensorDataList.first.temperature,
                unit: '°C',
                progressValue: _sensorDataList.first.temperature,
                color: Colors.red,
              ),
              _buildParameterCard(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: _sensorDataList.first.humidity,
                unit: '%',
                progressValue: _sensorDataList.first.humidity,
                color: Colors.blue,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildParameterCard(
                icon: Icons.lightbulb,
                label: 'Light',
                value: _sensorDataList.first.ambientLight,
                unit: 'lux',
                progressValue: _sensorDataList.first.ambientLight,
                color: Colors.deepPurple,
              ),
              _buildParameterCard(
                icon: Icons.wb_sunny,
                label: 'UV Intensity',
                value: _sensorDataList.first.uvIntensity,
                unit: 'UVI',
                progressValue: _sensorDataList.first.uvIntensity,
                color: Colors.deepPurple,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildParameterCard(
                icon: Icons.hearing,
                label: 'Sound',
                value: _sensorDataList.first.ambientSound,
                unit: 'dB',
                progressValue: _sensorDataList.first.ambientSound,
                color: Colors.grey,
              ),
              _buildParameterCard(
                icon: Icons.gas_meter_outlined,
                label: 'CO2',
                value: _sensorDataList.first.co2Level,
                unit: 'ppm',
                progressValue: _sensorDataList.first.co2Level,
                color: Colors.grey,
              ),
            ],
          ),
        ],
            ),
      );
  }


  Widget _buildParameterCard({
    required IconData icon,
    required String label,
    required double value,
    required String unit,
    required double progressValue,
    required Color color,
  }) {

    // double normalizedValue = value / 100; // Normalize value
    double normalizedProgress = progressValue / 100; // Normalize progress value

    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        value.toString() + ' $unit',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _animationController.value * normalizedProgress, // Use normalized progress
                    backgroundColor: Colors.grey[300],
                    valueColor:
                    AlwaysStoppedAnimation<Color>(color), // Use custom color
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
