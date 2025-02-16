import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const _key = 'isDarkMode';

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);
  }

  Future<bool> getDarkMode() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}