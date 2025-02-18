import 'package:flutter/material.dart';
import 'package:restaurant_app/config/style/typography/restaurant_text_style.dart';

class RestaurantTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RestaurantTextStyle.displayLarge,
      displayMedium: RestaurantTextStyle.displayMedium,
      displaySmall: RestaurantTextStyle.displaySmall,
      headlineLarge: RestaurantTextStyle.headlineLarge,
      headlineMedium: RestaurantTextStyle.headlineMedium,
      headlineSmall: RestaurantTextStyle.headlineSmall,
      titleLarge: RestaurantTextStyle.titleLarge,
      titleMedium: RestaurantTextStyle.titleMedium,
      titleSmall: RestaurantTextStyle.titleSmall,
      bodyLarge: RestaurantTextStyle.bodyLargeBold,
      bodyMedium: RestaurantTextStyle.bodyLargeMedium,
      bodySmall: RestaurantTextStyle.bodyLargeRegular,
      labelLarge: RestaurantTextStyle.labelLarge,
      labelMedium: RestaurantTextStyle.labelMedium,
      labelSmall: RestaurantTextStyle.labelSmall,
    );
  }

  ThemeData lightMode = ThemeData(
      brightness: Brightness.light,
      textTheme: _textTheme,
      colorScheme: ColorScheme.light(
        surface: Colors.grey.shade300,
        primary: Colors.grey.shade200,
        secondary: Colors.grey.shade100,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey.shade200,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 24),
        unselectedIconTheme: const IconThemeData(size: 20),
      ));

  ThemeData darkMode = ThemeData(
      brightness: Brightness.dark,
      textTheme: _textTheme,
      colorScheme: ColorScheme.dark(
        surface: Colors.grey.shade900,
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade700,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey.shade900,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade500,
          selectedIconTheme: const IconThemeData(size: 24),
          unselectedIconTheme: const IconThemeData(size: 20)));
}
