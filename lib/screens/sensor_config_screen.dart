import 'package:flutter/material.dart';

class SensorConfigurationScreen extends StatefulWidget {
  @override
  _SensorConfigurationScreenState createState() =>
      _SensorConfigurationScreenState();
}

class _SensorConfigurationScreenState extends State<SensorConfigurationScreen> {
  // Hardcoded lists for sensors and zones
  List<String> sensors = ['Sensor 1', 'Sensor 2', 'Sensor 3'];
  List<String> zones = ['Zone 1', 'Zone 2', 'Zone 3'];

  String selectedSensor = 'Sensor 1';
  String selectedZone = 'Zone 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Configuration'),
        backgroundColor: const Color.fromARGB(255, 165, 152, 232),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Sensor',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    DropdownButton<String>(
                      value: selectedSensor,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSensor = newValue!;
                        });
                      },
                      items: sensors.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Zone',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    DropdownButton<String>(
                      value: selectedZone,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedZone = newValue!;
                        });
                      },
                      items: zones.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Perform action on button press, like saving configuration
                // For now, just print the selected sensor and zone
                print('Selected Sensor: $selectedSensor');
                print('Selected Zone: $selectedZone');
              },
              child: const Text('Save Configuration'),
            ),
          ],
        ),
      ),
    );
  }
}
