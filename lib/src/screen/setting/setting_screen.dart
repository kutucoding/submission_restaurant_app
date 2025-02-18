// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:restaurant_app/src/screen/setting/notification_setting_screen.dart';
import 'package:restaurant_app/src/screen/setting/theme_screen.dart';
import 'package:restaurant_app/src/services/local_notification_service.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final service = LocalNotificationService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationSettingsScreen(service: service),
                  ),
                );
              },
              child: Container(
                height: 90,
                width: double.infinity,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notification',
                      ),
                      Icon(Icons.arrow_circle_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThemeScreen(),
                  ),
                );
              },
              child: Container(
                height: 90,
                width: double.infinity,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Setting',
                      ),
                      Icon(Icons.arrow_circle_right_outlined)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
