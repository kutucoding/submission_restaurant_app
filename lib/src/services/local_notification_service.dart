import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    
class LocalNotificationService {
  Future<void> init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<bool> _isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
  }

  Future<bool> _requestAndroidNotificationPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;
  }

  Future<bool> _requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.requestExactAlarmsPermission() ??
    false;
  }

  Future<bool?> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iOSImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      return await iOSImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImplementation = 
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
      final requestNotificationsPermission = 
      await androidImplementation?.requestNotificationsPermission();
      final notificationEnabled = await _isAndroidPermissionGranted();
      final requestAlarmEnabled = await _requestAndroidNotificationPermission();
      return (requestNotificationsPermission ?? false) && notificationEnabled && requestAlarmEnabled;
    } else {
      return false;
    }
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String channelId = "1",
    String channelName = "Simple Notification",
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        importance: Importance.max,
        priority: Priority.high,
        sound: const RawResourceAndroidNotificationSound('meal_reminder'));
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  // untuk mengetahui zona waktu perangkat
  Future<void> configureLocalTimeZone() async{
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  // mindblowing
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  // // mengatur jadwal munculnya notifikasi
  // tz.TZDateTime _nextInstanceOfElevenAM() {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduleDate =
  //   tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
  //   if (scheduleDate.isBefore(now)) {
  //     scheduleDate = scheduleDate.add(const Duration(days: 1));
  //   }
  //   return scheduleDate;
  // }

  // Future<void> scheduleDailyElevenAMNotification({
  //   required int id,
  //   String channelId = "2",
  //   String channelName = "Schedule Notification",
  // }) async {
  //   final androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     channelId, 
  //     channelName,
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //     );
  //      const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
 
  //  final notificationDetails = NotificationDetails(
  //    android: androidPlatformChannelSpecifics,
  //    iOS: iOSPlatformChannelSpecifics,
  //  );
 
  //  final datetimeSchedule = _nextInstanceOfElevenAM();
 
  //  await flutterLocalNotificationsPlugin.zonedSchedule(
  //    id,
  //    'Daily scheduled notification title',
  //    'This is a body of daily scheduled notification',
  //    datetimeSchedule,
  //    notificationDetails,
  //    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //    uiLocalNotificationDateInterpretation:
  //        UILocalNotificationDateInterpretation.wallClockTime,
  //    matchDateTimeComponents: DateTimeComponents.time,
  //  );
  // }

  // mindblowing
  Future<void> scheduleDailyNotification({
  required int id,
  required String title,
  required String body,
  required int hour,
  required int minute,
  String channelId = "2",
  String channelName = "Schedule Notification",
}) async {
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channelId,
    channelName,
    importance: Importance.max,
    priority: Priority.high,
    sound: const RawResourceAndroidNotificationSound('meal_reminder'),
    ticker: 'ticker',
  );
  const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

  final notificationDetails = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  final scheduleDate = _nextInstanceOfTime(hour, minute);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    scheduleDate,
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.wallClockTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}


  // untuk mengetahui pending notifikasi
  Future<List<PendingNotificationRequest>> pendingNotificationRequest() async {
    final List<PendingNotificationRequest> pendingNotificationRequest =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotificationRequest;
  }

  // untuk membatalkannya
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
