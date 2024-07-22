import 'dart:math';
import 'package:environmental_monitoring_app/sensor_data.dart';

class AQICalculator {
  static int calculateAQI(SensorData sensorData) {
    double aqi = _calculateAQIPrimary(sensorData.pm25Level, 'pm25') +
        _calculateAQIPrimary(sensorData.pm10Level, 'pm10') +
        _calculateAQIPrimary(sensorData.coLevel, 'co') +
        _calculateAQIPrimary(sensorData.so2Level, 'so2') +
        _calculateAQIPrimary(sensorData.no2Level, 'no2') +
        _calculateAQIPrimary(sensorData.o3Level, 'o3');

    return aqi.round();
  }

  static double _calculateAQIPrimary(double concentration, String pollutant) {
    double aqi = 0; // Default value
    if (pollutant == 'pm25') {
      aqi = _calculateAQIForPM25(concentration);
    } else if (pollutant == 'pm10') {
      aqi = _calculateAQIForPM10(concentration);
    } else if (pollutant == 'co') {
      aqi = _calculateAQIForCO(concentration);
    } else if (pollutant == 'so2') {
      aqi = _calculateAQIForSO2(concentration);
    } else if (pollutant == 'no2') {
      aqi = _calculateAQIForNO2(concentration);
    } else if (pollutant == 'o3') {
      aqi = _calculateAQIForO3(concentration);
    }
    return aqi;
  }

  static double _calculateAQIForPM25(double concentration) {
    if (concentration <= 12.0) {
      return _calculateAQIInRange(concentration, 0, 12, 0, 50);
    } else if (concentration <= 35.4) {
      return _calculateAQIInRange(concentration, 12.1, 35.4, 51, 100);
    } else if (concentration <= 55.4) {
      return _calculateAQIInRange(concentration, 35.5, 55.4, 101, 150);
    } else if (concentration <= 150.4) {
      return _calculateAQIInRange(concentration, 55.5, 150.4, 151, 200);
    } else if (concentration <= 250.4) {
      return _calculateAQIInRange(concentration, 150.5, 250.4, 201, 300);
    } else if (concentration <= 350.4) {
      return _calculateAQIInRange(concentration, 250.5, 350.4, 301, 400);
    } else if (concentration <= 500.4) {
      return _calculateAQIInRange(concentration, 350.5, 500.4, 401, 500);
    } else {
      return _calculateAQIOutOfRange(concentration);
    }
  }
  static double _calculateAQIForPM10(double concentration) {
    if (concentration <= 54) {
      return _calculateLinearAQI(concentration, 0, 54, 0, 50);
    } else if (concentration <= 154) {
      return _calculateLinearAQI(concentration, 55, 154, 51, 100);
    } else if (concentration <= 254) {
      return _calculateLinearAQI(concentration, 155, 254, 101, 150);
    } else if (concentration <= 354) {
      return _calculateLinearAQI(concentration, 255, 354, 151, 200);
    } else if (concentration <= 424) {
      return _calculateLinearAQI(concentration, 355, 424, 201, 300);
    } else if (concentration <= 504) {
      return _calculateLinearAQI(concentration, 425, 504, 301, 400);
    } else {
      return _calculateLinearAQI(concentration, 505, 604, 401, 500);
    }
  }

  static double _calculateAQIForCO(double concentration) {
    if (concentration <= 4.4) {
      return _calculateLinearAQI(concentration, 0, 4.4, 0, 50);
    } else if (concentration <= 9.4) {
      return _calculateLinearAQI(concentration, 4.5, 9.4, 51, 100);
    } else if (concentration <= 12.4) {
      return _calculateLinearAQI(concentration, 9.5, 12.4, 101, 150);
    } else if (concentration <= 15.4) {
      return _calculateLinearAQI(concentration, 12.5, 15.4, 151, 200);
    } else if (concentration <= 30.4) {
      return _calculateLinearAQI(concentration, 15.5, 30.4, 201, 300);
    } else if (concentration <= 40.4) {
      return _calculateLinearAQI(concentration, 30.5, 40.4, 301, 400);
    } else {
      return _calculateLinearAQI(concentration, 40.5, 50.4, 401, 500);
    }
  }

  static double _calculateAQIForSO2(double concentration) {
    if (concentration <= 35) {
      return _calculateLinearAQI(concentration, 0, 35, 0, 50);
    } else if (concentration <= 75) {
      return _calculateLinearAQI(concentration, 36, 75, 51, 100);
    } else if (concentration <= 185) {
      return _calculateLinearAQI(concentration, 76, 185, 101, 150);
    } else if (concentration <= 304) {
      return _calculateLinearAQI(concentration, 186, 304, 151, 200);
    } else if (concentration <= 604) {
      return _calculateLinearAQI(concentration, 305, 604, 201, 300);
    } else if (concentration <= 804) {
      return _calculateLinearAQI(concentration, 605, 804, 301, 400);
    } else {
      return _calculateLinearAQI(concentration, 805, 1004, 401, 500);
    }
  }

  static double _calculateAQIForNO2(double concentration) {
    if (concentration <= 53) {
      return _calculateLinearAQI(concentration, 0, 53, 0, 50);
    } else if (concentration <= 100) {
      return _calculateLinearAQI(concentration, 54, 100, 51, 100);
    } else if (concentration <= 360) {
      return _calculateLinearAQI(concentration, 101, 360, 101, 150);
    } else if (concentration <= 649) {
      return _calculateLinearAQI(concentration, 361, 649, 151, 200);
    } else if (concentration <= 1249) {
      return _calculateLinearAQI(concentration, 650, 1249, 201, 300);
    } else if (concentration <= 1649) {
      return _calculateLinearAQI(concentration, 1250, 1649, 301, 400);
    } else {
      return _calculateLinearAQI(concentration, 1650, 2049, 401, 500);
    }
  }

  static double _calculateAQIForO3(double concentration) {
    if (concentration <= 54) {
      return _calculateLinearAQI(concentration, 0, 54, 0, 50);
    } else if (concentration <= 70) {
      return _calculateLinearAQI(concentration, 55, 70, 51, 100);
    } else if (concentration <= 85) {
      return _calculateLinearAQI(concentration, 71, 85, 101, 150);
    } else if (concentration <= 105) {
      return _calculateLinearAQI(concentration, 86, 105, 151, 200);
    } else if (concentration <= 200) {
      return _calculateLinearAQI(concentration, 106, 200, 201, 300);
    } else if (concentration <= 504) {
      return _calculateLinearAQI(concentration, 201, 504, 301, 400);
    } else {
      return _calculateLinearAQI(concentration, 505, 604, 401, 500);
    }
  }

  static double _calculateLinearAQI(double concentration, double cLow, double cHigh, double iLow, double iHigh) {
    return ((iHigh - iLow) / (cHigh - cLow)) * (concentration - cLow) + iLow;
  }


  static double _calculateAQIInRange(
      double concentration, double low, double high, double aqiLow, double aqiHigh) {
    return ((aqiHigh - aqiLow) / (high - low)) * (concentration - low) + aqiLow;
  }

  static double _calculateAQIOutOfRange(double concentration) {
    // Handle out of range values, e.g., concentration > 500.4
    return 500; // Maximum AQI value
  }
}
