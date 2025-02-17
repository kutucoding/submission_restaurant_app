import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/notification/local_notification_provider.dart';

import '../../services/local_notification_service.dart';

class NotificationSettingsScreen extends StatelessWidget {
  final LocalNotificationService service;

  const NotificationSettingsScreen({Key? key, required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalNotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Notification Time:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: provider.selectedTime,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  provider.setSelectedTime(newValue);
                }
              },
              items: provider.availableTimes.map((String time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enable Notification:',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: provider.isNotificationEnabled,
                  onChanged: (bool value) {
                    provider.toggleNotification(value, service);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
