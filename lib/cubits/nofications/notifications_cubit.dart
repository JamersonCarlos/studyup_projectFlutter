import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

import '../../models/notifications.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  late AndroidNotificationDetails androidNotification;
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  
  NotificationsCubit() : super(NotificationsInitial()) {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    localNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    _setupNotifications();
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

  Future<void> _onSelectNotification(String? payload) async {
    if (payload != null && payload!.isNotEmpty) {
      print("usuario clickou na notificaçao");
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

    DateTime date = DateTime.now().add(const Duration(seconds: 4));
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
