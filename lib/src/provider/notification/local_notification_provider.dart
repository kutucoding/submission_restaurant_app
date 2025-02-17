import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/src/services/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permisson = false;
  bool? get permission => _permisson;

  List<PendingNotificationRequest> pendingNotificationRequest = [];

  // mind blowing

  final List<String> availableTimes = ['10:00', '11:00', '12:00', '13:00', '14,00', '15:00'];
  String _selectedTime = '10:00';
  bool _isNotificationEnabled = false;

  String get selectedTime => _selectedTime;
  bool get isNotificationEnabled => _isNotificationEnabled;

  Future<void> requestPermission() async {
    _permisson = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  Future<void> showNotification() async {
    _notificationId += 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new Notification with id $_notificationId",
    );
  }

  // mindblowing

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
        title: 'Reminder',
        body: 'This is your reminder!',
        hour: hour,
        minute: minute,
      );
    } else {
      service.cancelNotification(1);
    }

    notifyListeners();
  }

  // fungsi untuk eksekusi notifikasi terjadwal
  // void scheduleDailyElevenAMNotification() {
  //   _notificationId += 1;
  //   flutterNotificationService.scheduleDailyTenAMNotification(
  //    id: _notificationId,
  //  );
  // }

  // fungsi untuk mencatat notifikasi terjadwal
  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequest =
        await flutterNotificationService.pendingNotificationRequest();
    notifyListeners();
  }

  // fungsi untuk mencancel notifikasi terjadwal
  Future<void> cancelNotification(int id) async {
    await flutterNotificationService.cancelNotification(id);
  }
}
