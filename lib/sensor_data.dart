class SensorData {
  double temperature;
  double humidity;
  double co2Level;
  double coLevel; // CO level
  double no2Level; // NO2 level
  double so2Level; // SO2 level
  double pm10Level; // PM10 level
  double pm25Level; // PM2.5 level
  DateTime timestamp;
  double o3Level; // O3 level
  double ambientLight;
  double uvIntensity;
  double ambientSound;
  double latitude; // Latitude
  double longitude; // Longitude

  SensorData({
    this.temperature = 0,
    this.humidity = 0,
    this.co2Level = 0,
    this.coLevel = 0,
    this.no2Level = 0,
    this.so2Level = 0,
    this.pm10Level = 0,
    this.pm25Level = 0,
    required this.timestamp,
    this.o3Level = 0,
    this.ambientLight = 0,
    this.uvIntensity = 0,
    this.ambientSound = 0,
    required this.latitude,
    required this.longitude,
  });
}
