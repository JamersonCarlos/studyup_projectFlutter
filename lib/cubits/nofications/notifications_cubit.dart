import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../../models/notifications.dart';
import '../../services/notifications_service.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late final NotificationsService notificationsService;
  late final BuildContext context;

  NotificationsCubit(context) : super(NotificationsInitial()) {
    this.context = context;
    this.notificationsService = NotificationsService(this.context);
  }

  Future<void> initialize() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
    );
    // _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging
        .getToken()
        .then((token) => print("Token = " + token.toString()));
    _onMessage();
  }

  void _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        notificationsService.showNotfication(
          ReceivedNotification(
              id: android.hashCode,
              title: notification.title,
              body: notification.body,
              payload: message.data['route'] ?? ''),
        );
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToRoute);
  }

  _goToRoute(message) {
    notificationsService.navegator(message.data['route'] ?? '');
    print('rotas excutadas');
  }
}
