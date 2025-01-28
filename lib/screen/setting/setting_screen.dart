import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting/theme_provider.dart';
import 'package:restaurant_app/style/components/box.dart';
import 'package:restaurant_app/style/components/button.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: MyBox(
            color: Theme.of(context).colorScheme.primary,
            child: MyButton(color: Theme.of(context).colorScheme.secondary, 
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            })),
      ),
    );
  }
}
