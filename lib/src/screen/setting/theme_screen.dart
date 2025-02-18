import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/setting/theme_provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Setting'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(child:
          Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        bool isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wb_sunny,
              color: Colors.amber,
              size: 24,
            ),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
              activeColor: Colors.amber,
              inactiveThumbColor: Colors.blue,
              inactiveTrackColor: Colors.grey.shade400,
              activeTrackColor: Colors.grey.shade700,
            ),
            const Icon(
              Icons.nightlight_round,
              color: Colors.blue,
              size: 24,
            )
          ],
        );
      })),
    );
  }
}
