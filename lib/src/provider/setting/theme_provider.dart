import 'package:flutter/material.dart';
import 'package:restaurant_app/config/style/theme/theme.dart';
import 'package:restaurant_app/src/utils/theme_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = RestaurantTheme().lightMode;
  final ThemePreferences _preferences = ThemePreferences();

  ThemeData get themeData => _themeData;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    final isDarkMode = await _preferences.getDarkMode();
    _themeData =
        isDarkMode ? RestaurantTheme().darkMode : RestaurantTheme().lightMode;
    notifyListeners();
  }

  void toggleTheme() {
    final isDarkMode = _themeData == RestaurantTheme().lightMode;
    _themeData =
        isDarkMode ? RestaurantTheme().darkMode : RestaurantTheme().lightMode;
    _preferences.setDarkMode(isDarkMode);
    notifyListeners();
  }
}
