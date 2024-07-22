import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:environmental_monitoring_app/screens/dashboard_screen.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color(0xFF147DD0),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color(0xFF147DD0).withOpacity(.5),
);

void main() {
  // Initialize the geocoding plugin
  GeocodingPlatform.instance;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Environmental Monitoring',
      themeMode: ThemeMode.system, // Set the theme mode to follow the system's theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.blue[100],
          inactiveTrackColor: Colors.grey[400],
          disabledActiveTrackColor: Colors.grey[500],
          disabledInactiveTrackColor: Colors.grey[300],
          activeTickMarkColor: Colors.blue[700],
          inactiveTickMarkColor: Colors.grey[500],
          disabledActiveTickMarkColor: Colors.grey[500],
          disabledInactiveTickMarkColor: Colors.grey[300],
          thumbColor: Colors.blue,
          disabledThumbColor: Colors.grey[400],
          overlayColor: Colors.blue.withAlpha(32),
          valueIndicatorColor: Colors.blue,
          thumbShape: RoundSliderThumbShape(),
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          showValueIndicator: ShowValueIndicator.always,
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey[600],
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.blue[100],
          brightness: Brightness.light,
          disabledColor: Colors.grey[400],
          labelPadding: EdgeInsets.all(8),
          labelStyle: TextStyle(color: Colors.black),
          padding: EdgeInsets.all(8),
          secondaryLabelStyle: TextStyle(color: Colors.white),
          secondarySelectedColor: Colors.blue,
          selectedColor: Colors.blue[400],
          shape: StadiumBorder(),
        ),



        // Define other light theme properties
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        cardTheme:  CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.indigo[100],
          inactiveTrackColor: Colors.grey[600],
          disabledActiveTrackColor: Colors.grey[700],
          disabledInactiveTrackColor: Colors.grey[500],
          activeTickMarkColor: Colors.indigo[300],
          inactiveTickMarkColor: Colors.grey[500],
          disabledActiveTickMarkColor: Colors.grey[700],
          disabledInactiveTickMarkColor: Colors.grey[500],
          thumbColor: Colors.indigo,
          disabledThumbColor: Colors.grey[600],
          overlayColor: Colors.indigo.withAlpha(32),
          valueIndicatorColor: Colors.indigoAccent,
          thumbShape: RoundSliderThumbShape(),
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          showValueIndicator: ShowValueIndicator.always,
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[500],
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.indigo[700],
          brightness: Brightness.dark,
          disabledColor: Colors.grey[600],
          labelPadding: EdgeInsets.all(8),
          labelStyle: TextStyle(color: Colors.white),
          padding: EdgeInsets.all(8),
          secondaryLabelStyle: TextStyle(color: Colors.black),
          secondarySelectedColor: Colors.indigo,
          selectedColor: Colors.indigoAccent,
          shape: StadiumBorder(),
        ),
        // Define other dark theme properties

      ),
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}
