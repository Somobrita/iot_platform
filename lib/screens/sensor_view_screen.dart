import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
class SensorviewScreen extends StatefulWidget {
  @override
  _SensorviewScreenState createState() => _SensorviewScreenState();
}

class _SensorviewScreenState extends State<SensorviewScreen> {
  List<Marker> _markers = [];
  List<bool> _parameterVisibility = [];
  double _currentZoom = 15.0; // Initial zoom level
  MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _currentZoom = _currentZoom; // Set initial zoom level
    // Initialize visibility for each parameter
    _parameterVisibility = List.filled(12, true);
    // Populate markers for each parameter
    _populateMarkers();
  }

  void _populateMarkers() {
    // Adding markers for each parameter
    final parameters = [
      {
        'icon': Icons.heat_pump_rounded,
        'color': Colors.blue,
        'label': 'Temperature',
        'value': 23,
        'coordinates': const LatLng(22.575684, 88.443124)
      },
      {
        'icon': Icons.water_drop,
        'color': Colors.blue,
        'label': 'Humidity',
        'value': 60,
        'coordinates': const LatLng(22.572910, 88.438103)
      },
      {
        'icon': Icons.air,
        'color': Colors.blue,
        'label': 'PPM2.5',
        'value': 15,
        'coordinates': const LatLng(22.567243, 88.436086)
      },
      {
        'icon': Icons.air_outlined,
        'color': Colors.blue,
        'label': 'PPM10',
        'value': 30,
        'coordinates': const LatLng(22.569343, 88.429648)
      },
      {
        'icon': Icons.gas_meter,
        'color': Colors.blue,
        'label': 'NO2',
        'value': 10,
        'coordinates': const LatLng(22.574891, 88.433725)
      },
      {
        'icon': Icons.gas_meter,
        'color': Colors.blue,
        'label': 'CO2',
        'value': 500,
        'coordinates': const LatLng(22.576635, 88.429262)
      },
      {
        'icon': Icons.gas_meter,
        'color': Colors.blue,
        'label': 'O3',
        'value': 40,
        'coordinates': const LatLng(22.573861, 88.427631)
      },
      {
        'icon': Icons.gas_meter_outlined,
        'color': Colors.blue,
        'label': 'SO2',
        'value': 8,
        'coordinates': const LatLng(22.570310, 88.431541)
      },
      {
        'icon': Icons.gas_meter,
        'color': Colors.blue,
        'label': 'CO',
        'value': 12,
        'coordinates': const LatLng(22.572711, 88.436501)
      },
      {
        'icon': Icons.lightbulb,
        'color': Colors.blue,
        'label': 'Ambient light',
        'value': 80,
        'coordinates': const LatLng(22.577891, 88.431702)
      },
      {
        'icon': Icons.wb_sunny,
        'color': Colors.blue,
        'label': 'UV intensity',
        'value': 6,
        'coordinates': const LatLng(22.579512, 88.438215)
      },
      {
        'icon': Icons.hearing,
        'color': Colors.blue,
        'label': 'Ambient sound',
        'value': 45,
        'coordinates': const LatLng(22.582910, 88.43803)
      },
    ];
    _markers.clear(); // Clear existing markers before populating

    _markers.addAll(parameters.asMap().entries.map((entry) {
      final index = entry.key;
      final param = entry.value;
      final isVisible = _parameterVisibility[index];
      return Marker(
        width: 80.0,
        height: 80.0,
        point: param['coordinates'] as LatLng,
        child: isVisible
            ? GestureDetector(
          onTap: () {
            setState(() {
              _showData(param['label'] as String, param['value'] as int);

            });
          },
          child: Icon(
            param['icon'] as IconData,
            color: param['color'] as Color,
            size: 40,
          ),
        )
            : SizedBox.shrink(),
      );
    }));
  }
  void _showData(String parameter, int value) {
    // Show data when marker is tapped or hovered
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(parameter),
          content: Text('$value'), // Show parameter value
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensorview'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: const LatLng(22.576635, 88.429262),
              zoom: _currentZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: LegendWidget(),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentZoom += 0.5;
                      _mapController.move(_mapController.center, _currentZoom);
                    });
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentZoom -= 1;
                      _mapController.move(_mapController.center, _currentZoom);
                    });
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget LegendWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLegendItem(Icons.heat_pump_rounded, 'Temperature', 0),
            SizedBox(height: 5),
            _buildLegendItem(Icons.water_drop, 'Humidity', 1),
            SizedBox(height: 5),
            _buildLegendItem(Icons.air, 'PPM2.5', 2),
            SizedBox(height: 5),
            _buildLegendItem(Icons.air_outlined, 'PPM10', 3),
            SizedBox(height: 5),
            _buildLegendItem(Icons.gas_meter, 'NO2', 4),
            SizedBox(height: 5),
            _buildLegendItem(Icons.gas_meter, 'CO', 5),
            SizedBox(height: 5),
            _buildLegendItem(Icons.gas_meter_outlined, 'SO2', 6),
            SizedBox(height: 5),
            _buildLegendItem(Icons.gas_meter, 'CO2', 7),
            SizedBox(height: 5),
            _buildLegendItem(Icons.gas_meter, 'O3', 8),
            SizedBox(height: 5),
            _buildLegendItem(Icons.lightbulb, 'Ambient light', 9),
            SizedBox(height: 5),
            _buildLegendItem(Icons.wb_sunny, 'UV intensity', 10),
            SizedBox(height: 5),
            _buildLegendItem(Icons.hearing, 'Ambient sound', 11),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _parameterVisibility[index] = !_parameterVisibility[index];
          _populateMarkers(); // Update markers when visibility changes
        });
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: _parameterVisibility[index] ? Colors.blue : Colors.grey,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: _parameterVisibility[index] ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

}