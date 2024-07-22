import 'package:air_quality/air_quality.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AQIService {
  static Future<int> getAQI(LatLng location) async {
    AirQuality airQuality = AirQuality('b457b09b1ebd61a8f8cf51e9d155c4d6a73d35bf');
    // Fetch air quality data based on geo-location
    AirQualityData airQualityData = await airQuality.feedFromGeoLocation(location.latitude, location.longitude);
    // Get AQI from the fetched data
    int aqi = airQualityData.airQualityIndex;
    return aqi;
  }
}
