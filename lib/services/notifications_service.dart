import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/pomodoro.dart';


class NotificationsService {
  late AndroidNotificationDetails androidNotification;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late final BuildContext context;
  
  NotificationsService(context) {
    localNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    _setupNotifications();
    this.context = context;
  } 

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tzData.initializeTimeZones();
    final tzName = await FlutterNativeTimezone.getLocalTimezone();
    if(tzName != "GMT"){
    tz.setLocalLocation(tz.getLocation(tzName));
    }
  }

  Future<void> _initializeNotifications() async {
    const android = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // adiciona um icone as notificacoes

  
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  Future<void> _onSelectNotification(String? payload) async { //a ideia e que va apar uma rota especifica
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const PomodoroPage()),
                  (Route<dynamic> route) => false);
    }
  }

  showNotfication(ReceivedNotification notification) {

    androidNotification = const AndroidNotificationDetails(
        'Lembrentes_notifications',
        'lembretes',
        channelDescription: 'Este e o canal para lembretes',
        importance: Importance.max,
        priority: Priority.max,
        enableVibration: true);

    DateTime date = DateTime.now().add(const Duration(seconds: 3));
    localNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        tz.TZDateTime.from(date,tz.local),
        NotificationDetails(
          android: androidNotification,
        ),
        payload: notification.payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
        );
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
  
}
