import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:air_quality/air_quality.dart';


import '../widgets/linear_gauge_widgets.dart';

class GeoviewScreen extends StatefulWidget {
  @override
  _GeoviewScreenState createState() => _GeoviewScreenState();
}

class _GeoviewScreenState extends State<GeoviewScreen> {
  Map<LatLng, int?> aqiMap = {};
  double _currentZoom = 13.0; // Initial zoom level
  MapController _mapController = MapController();
  TextEditingController _locationController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _currentZoom = _currentZoom; // Set initial zoom level
    _fetchAQIForCoordinates();
    GeocodingPlatform.instance;
  }

  Future<void> _fetchAQIForCoordinates() async {
    try {
      AirQuality airQuality = AirQuality('b457b09b1ebd61a8f8cf51e9d155c4d6a73d35bf');
      for (var coordinate in coordinates) {
        var response = await airQuality.feedFromGeoLocation(coordinate.latitude, coordinate.longitude);
        setState(() {
          aqiMap[coordinate] = response?.airQualityIndex;
        });
      }
    } catch (e) {
      // Handle error, for example:
      print('Error fetching AQI: $e');
    }
  }

  Future<void> _searchAndShowLocation(String locationName) async {
    try {
      List<Location> locations = await locationFromAddress(locationName);
      if (locations.isNotEmpty) {
        LatLng searchedCoordinate = LatLng(locations.first.latitude, locations.first.longitude);
        var response = await AirQuality('b457b09b1ebd61a8f8cf51e9d155c4d6a73d35bf')
            .feedFromGeoLocation(searchedCoordinate.latitude, searchedCoordinate.longitude);
        setState(() {
          aqiMap[searchedCoordinate] = response?.airQualityIndex;
          _mapController.move(searchedCoordinate, _currentZoom);
        });
      } else {
        print('No location found for the given name');
      }
    } catch (e) {
      print('Error searching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geoview'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController, // Pass the map controller
            options: MapOptions(
              center: LatLng(22.576635, 88.429262),
              zoom: _currentZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: aqiMap.entries.map((entry) {
                  var coordinate = entry.key;
                  var aqi = entry.value;
                  return Marker(
                    width: 50.0,
                    height: 40.0,
                    point: coordinate,
                    child: _buildMarkerWidget(aqi),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: 'Enter location name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _searchAndShowLocation(_locationController.text);
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 80.0,
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
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentZoom -= 1;
                      _mapController.move(_mapController.center, _currentZoom);
                    });
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Center(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearGaugeWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMarkerWidget(int? aqi) {
  Color backgroundColor = _getBackgroundColor(aqi ?? 0);
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '${aqi ?? 'Loading...'}',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Color _getBackgroundColor(int aqi) {
  if (aqi <= 50) {
    return Colors.green.withOpacity(0.7);
  } else if (aqi <= 100) {
    return Colors.yellow.withOpacity(0.7);
  } else if (aqi <= 200) {
    return Colors.orange.withOpacity(0.7);
  } else if (aqi <= 300) {
    return Colors.red.withOpacity(0.7);
  } else if (aqi <= 400) {
    return Colors.blue.withOpacity(0.7);
  } else if (aqi <= 500) {
    return Colors.purple.withOpacity(0.7);
  } else {
    return Colors.deepPurple.withOpacity(0.7);
  }
}

List<LatLng> coordinates = [
  // Your provided coordinates
  // LatLng(22.584322, 88.438875),
  // LatLng(22.575684, 88.443124),
  // LatLng(22.572910, 88.438103),
  // LatLng(22.567243, 88.436086),
  // LatLng(22.569343, 88.429648),
  //LatLng(22.574891, 88.433725),
  //LatLng(22.576635, 88.429262),
  // LatLng(22.573861, 88.427631),
  // LatLng(22.577744, 88.422825),
  // LatLng(22.579725, 88.426044),
  //LatLng(22.573385, 88.420465),
  LatLng(22.576635, 88.429262),//Saltlake sector V
  LatLng(22.5726, 88.3639), // Victoria Memorial
  LatLng(22.5382, 88.3423), // Howrah Bridge
  LatLng(22.5726, 88.3639), // Eden Gardens
  LatLng(22.5524, 88.3410), // Salt Lake Stadium
  LatLng(22.5587, 88.3540), // Science City Kolkata
  LatLng(22.5734, 88.4366), // Park Street
  LatLng(22.5670, 88.3484), // South City Mall

  // Other cities in India
  LatLng(28.6139, 77.2090), // Delhi
  LatLng(18.5204, 73.8567), // Mumbai
  LatLng(13.0827, 80.2707), // Chennai
  LatLng(12.9716, 77.5946), // Bangalore
  LatLng(25.5941, 85.1376), // Patna
  LatLng(17.3850, 78.4867), // Hyderabad
  LatLng(26.9124, 75.7873), // Jaipur
];
