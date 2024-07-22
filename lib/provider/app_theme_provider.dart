import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

// provider to work with AppTheme
final appThemeProvider = ChangeNotifierProvider((ref) {
  return AppTheme(ref.watch(sharedPreferencesProvider));
});

// provider stores the instance SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((_) {
  return throw UnimplementedError();
});
final lightTheme = ThemeData.light();
final darkTheme = ThemeData.dark();

class AppTheme extends ChangeNotifier {
  AppTheme(this._prefs);

  final SharedPreferences _prefs;

  /// Get the current value from SharedPreferences.
  bool getTheme() => _prefs.getBool('isDarkMode') ?? false;

  /// Store the current value in SharedPreferences.
  void setTheme(bool isDarkMode) {
    _prefs.setBool('isDarkMode', isDarkMode);

    notifyListeners();
  }

  void setThemeLight(bool isDarkMode) {
    _prefs.clear();
    notifyListeners();
  }

  void toggleThemeOnLogout(ProviderContainer container) {
    final currentTheme = container.read(appThemeProvider);
    //final newTheme = currentTheme == LightTheme ? DarkTheme : LightTheme;
    container.read(appThemeProvider)._prefs.setBool('isDarkMode', false);
  }
}
