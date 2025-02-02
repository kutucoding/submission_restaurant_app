import 'package:flutter/material.dart';
import 'package:restaurant_app/style/typography/restaurant_text_style.dart';

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
    surface: const Color(0xffFAD8B8),
    primary:  Colors.grey.shade200,
    secondary: Colors.grey.shade100,
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: _textTheme,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  )
);

}