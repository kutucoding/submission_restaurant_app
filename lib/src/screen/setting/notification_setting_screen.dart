import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/notification/local_notification_provider.dart';

import '../../services/local_notification_service.dart';

class NotificationSettingsScreen extends StatefulWidget {
  final LocalNotificationService service;

  const NotificationSettingsScreen({super.key, required this.service});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
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
                    provider.toggleNotification(value, widget.service);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () async {
                await _checkPendingNotificationRequests();
              },
              child: Container(
                height: 40,
                width: 145,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Pending Notifications"),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkPendingNotificationRequests() async {
    final localNotificationProvider = context.read<LocalNotificationProvider>();
    await localNotificationProvider.checkPendingNotificationRequests(context);

    if (!mounted) {
      return;
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final pendingData = context.select(
              (LocalNotificationProvider provider) =>
                  provider.pendingNotificationRequest);
          return AlertDialog(
            title: Text(
              '${pendingData.length} pending notification request',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            content: SizedBox(
              height: 300,
              width: 300,
              child: ListView.builder(
                itemCount: pendingData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = pendingData[index];
                  return ListTile(
                    title: Text(
                      item.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item.body ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    contentPadding: EdgeInsets.zero,
                    trailing: IconButton(
                      onPressed: () {
                        localNotificationProvider
                          ..cancelNotification(item.id)
                          ..checkPendingNotificationRequests(context);
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                  );
                },
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondary,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3))
                      ]),
                  child: const Center(
                    child: Text("OK"),
                  ),
                ),
              )
            ],
          );
        });
  }
}
