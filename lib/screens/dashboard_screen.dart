import 'package:environmental_monitoring_app/screens/geo_view_screen.dart';
import 'package:environmental_monitoring_app/screens/sensor_config_screen.dart';
import 'package:environmental_monitoring_app/screens/sensor_view_screen.dart';
import 'package:environmental_monitoring_app/widgets/aqi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:environmental_monitoring_app/sensor_data.dart';
import 'package:environmental_monitoring_app/sensor_service.dart';
import 'package:environmental_monitoring_app/screens/aqi_parameters.dart';
import 'package:environmental_monitoring_app/screens/chart_content.dart';
import 'package:environmental_monitoring_app/widgets/linear_gauge_widgets.dart';
import 'package:environmental_monitoring_app/widgets/radial_gauge_widgets.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _aqi = 0;
  late List<SensorData> _sensorDataList = [];

  @override
  void initState() {
    super.initState();
    _updateSensorData();
  }

  // Function to update sensor data
  void _updateSensorData() {
    // Get sensor data for the last 24 hours
    List<SensorData> sensorDataList = SensorService.getSensorDataForLast24Hours();

    if (sensorDataList.isNotEmpty) {
      // Find the latest sensor data
      SensorData latestSensorData = sensorDataList.first;

      // Calculate AQI
      _aqi = AQICalculator.calculateAQI(latestSensorData);
    } else {
      // If no sensor data available, set AQI to a default value
      _aqi = 0;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environmental Monitor'),
        backgroundColor: const Color.fromARGB(255, 165, 152, 232),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      // Drawer widget
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 165, 152, 232),
              ),
              child: Text('Environmental Monitoring'),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardScreen()),
                );              },
            ),
            ListTile(
              title: const Text('Sensor Configuration'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SensorConfigurationScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Alarm'),
              onTap: () {
                // Update with your option 3 functionality
              },
            ),
            ListTile(
              title: const Text('Geo View'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GeoviewScreen()),
                );              },
            ),
            ListTile(
              title: const Text('Sensor View'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SensorviewScreen()),
                );              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 220, 219, 225),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Air Quality Index (IN)',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 5),
                          Center(
                            child: Card(
                              elevation: 4,
                              child: RadialGaugeWidget(aqi: _aqi), // Pass AQI to RadialGaugeWidget
                            ),
                          ),
                      const SizedBox(height: 5),
                    ],
                  ),
                  const TabBar(
                    tabs: [
                      Tab(text: 'AQI Parameters'),
                      Tab(text: 'Charts'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.5,
                    child: TabBarView(
                      children: [
                        // AQIParameters(sensorDataList: _sensorDataList),
                        AQIParameters(sensorDataList: _sensorDataList),

                        ChartContent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
