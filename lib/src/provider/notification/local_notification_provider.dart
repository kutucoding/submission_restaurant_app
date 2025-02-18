import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/src/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  bool? _permisson = false;
  bool? get permission => _permisson;

  List<PendingNotificationRequest> pendingNotificationRequest = [];

  final List<String> availableTimes = [
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14,00',
    '15:00'
  ];
  String _selectedTime = '10:00';
  bool _isNotificationEnabled = false;

  String get selectedTime => _selectedTime;
  bool get isNotificationEnabled => _isNotificationEnabled;

  Future<void> requestPermission() async {
    _permisson = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void setSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void toggleNotification(bool isEnabled, LocalNotificationService service) {
    _isNotificationEnabled = isEnabled;

    if (isEnabled) {
      final parts = _selectedTime.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      service.scheduleDailyNotification(
        id: 1,
        title: 'Hai 👋, Udah makan?',
        body: 'Yuk makan, nanti sakit loh 😉',
        hour: hour,
        minute: minute,
      );
    } else {
      service.cancelNotification(1);
    }

    notifyListeners();
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequest =
        await flutterNotificationService.pendingNotificationRequest();
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
  }
}
