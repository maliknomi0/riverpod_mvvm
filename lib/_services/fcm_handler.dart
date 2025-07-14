import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpordmvvm/_services/local_notification_service.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await LocalNotificationService.init();
  final notification = message.notification;
  if (notification != null) {
    await LocalNotificationService.show(
      title: notification.title ?? '',
      body: notification.body ?? '',
    );
  }
}

class FCMHandler {
  static bool _initialized = false;

  static Future<void> setupNotificationHandlers() async {
    if (_initialized) return;
    _initialized = true;

    await LocalNotificationService.init();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        LocalNotificationService.show(
          title: notification.title ?? '',
          body: notification.body ?? '',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when the app is opened from a notification
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      final notification = initialMessage.notification;
      if (notification != null) {
        LocalNotificationService.show(
          title: notification.title ?? '',
          body: notification.body ?? '',
        );
      }
    }
  }
}
