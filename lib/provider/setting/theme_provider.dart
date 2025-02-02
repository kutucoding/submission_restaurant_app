import 'package:flutter/material.dart';
import 'package:restaurant_app/style/theme/theme.dart';


class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = RestaurantTheme().lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == RestaurantTheme().lightMode){
      themeData = RestaurantTheme().darkMode;
    } else {
      themeData = RestaurantTheme().lightMode;
    }
  }
}