import 'dart:math';

import 'package:environmental_monitoring_app/sensor_data.dart';

class SensorService {
  static List<SensorData> getSensorDataForLast24Hours() {
    return _generateSensorDataForDuration(hours: 24);
  }

  static List<SensorData> getSensorDataForLast8Hours() {
    return _generateSensorDataForDuration(hours: 8);
  }

  static List<SensorData> getSensorDataForLastWeek() {
    return _generateSensorDataForDuration(days: 7);
  }

  static List<SensorData> getSensorDataForLastMonth() {
    return _generateSensorDataForDuration(days: 30);
  }

  static List<SensorData> getSensorDataForLast6Months() {
    return _generateSensorDataForDuration(days: 30 * 6);
  }

  static List<SensorData> _generateSensorDataForDuration({int hours = 0, int days = 0}) {
    List<SensorData> data = [];
    DateTime now = DateTime.now();

    double baseTemperature = 22.0;
    double baseHumidity = 50.0;
    double baseCO2Level = 400;
    double baseCOLevel = 0.0;
    double baseNO2Level = 10.0;
    double baseSO2Level = 5.0;
    double basePM10Level = 20.0;
    double basePM25Level = 10.0;
    double baseO3Level = 0.03; // Example baseline O3 level
    double baseAmbientLight = 200; // Example baseline ambient light level
    double baseUVIntensity = 5; // Example baseline UV intensity
    double baseAmbientSound = 50; // Example baseline ambient sound level

    int totalHours = hours + days * 24;
    for (int i = 0; i < totalHours; i++) {
      double temperature = _generateRandomAroundBaseline(baseTemperature, 2.0, 18.0, 26.0);
      double humidity = _generateRandomAroundBaseline(baseHumidity, 5.0, 45.0, 55.0);
      double co2Level = _generateRandomAroundBaseline(baseCO2Level, 20.0, 0, double.maxFinite);
      double coLevel = _generateRandomAroundBaseline(baseCOLevel, 5.0, 0, double.maxFinite);
      double no2Level = _generateRandomAroundBaseline(baseNO2Level, 2.0, 0, double.maxFinite);
      double so2Level = _generateRandomAroundBaseline(baseSO2Level, 1, 0, double.maxFinite);
      double pm10Level = _generateRandomAroundBaseline(basePM10Level, 5, 0, double.maxFinite);
      double pm25Level = _generateRandomAroundBaseline(basePM25Level, 3, 0, double.maxFinite);
      double o3Level = _generateRandomAroundBaseline(baseO3Level, 0.01, 0.01, 0.05); // Example variation for O3 level
      double ambientLight = _generateRandomAroundBaseline(baseAmbientLight, 50, 100, 300); // Example variation for ambient light
      double uvIntensity = _generateRandomAroundBaseline(baseUVIntensity, 2, 3, 7); // Example variation for UV intensity
      double ambientSound = _generateRandomAroundBaseline(baseAmbientSound, 10, 40, 60); // Example variation for ambient sound

      // Generate latitude and longitude near Salt Lake Sector 5, India
      double latitude = 22.5782 + Random().nextDouble() * 0.02; // Random deviation around Salt Lake Sector 5 latitude
      double longitude = 88.4348 + Random().nextDouble() * 0.02; // Random deviation around Salt Lake Sector 5 longitude

      data.add(
        SensorData(
          temperature: double.parse(temperature.toStringAsFixed(2)),
          humidity: double.parse(humidity.toStringAsFixed(2)),
          co2Level: double.parse(co2Level.toStringAsFixed(2)),
          coLevel: double.parse(coLevel.toStringAsFixed(2)),
          no2Level: double.parse(no2Level.toStringAsFixed(2)),
          so2Level: double.parse(so2Level.toStringAsFixed(2)),
          pm10Level: double.parse(pm10Level.toStringAsFixed(2)),
          pm25Level: double.parse(pm25Level.toStringAsFixed(2)),
          timestamp: now.subtract(Duration(hours: i)),
          o3Level: double.parse(o3Level.toStringAsFixed(2)),
          ambientLight: double.parse(ambientLight.toStringAsFixed(2)),
          uvIntensity: double.parse(uvIntensity.toStringAsFixed(2)),
          ambientSound: double.parse(ambientSound.toStringAsFixed(2)),
          latitude: latitude,
          longitude: longitude,
        ),
      );
    }
    return data;
  }

  static double _generateRandomAroundBaseline(double baseline, double deviation, double min, double max) {
    double randomDeviation = Random().nextDouble() * deviation;
    double randomSign = Random().nextBool() ? 1 : -1;
    double value = baseline + randomSign * randomDeviation;
    return value.clamp(min, max); // Ensure within bounds
  }
}
