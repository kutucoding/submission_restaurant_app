import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/src/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;
  late SharedPreferences _prefs;

  LocalNotificationProvider(this.flutterNotificationService) {
    _loadPreferences();
  }

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
  String _selectedTime = '11:00';
  bool _isNotificationEnabled = false;

  String get selectedTime => _selectedTime;
  bool get isNotificationEnabled => _isNotificationEnabled;

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _selectedTime = _prefs.getString('selectedTime') ?? '11:00';
    _isNotificationEnabled = _prefs.getBool('isNotificationEnabled') ?? false;
  }

  Future<void> requestPermission() async {
    _permisson = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void setSelectedTime(String time) async{
    _selectedTime = time;
    await _prefs.setString('selectedTime', time);
    notifyListeners();
  }

  void toggleNotification(bool isEnabled, LocalNotificationService service) async {
    _isNotificationEnabled = isEnabled;
    await _prefs.setBool('isNotificationEnabled', isEnabled);

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
