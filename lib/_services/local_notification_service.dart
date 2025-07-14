import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

/// Handles all local notification functionality.
class LocalNotificationService {
  LocalNotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'default_channel',
    'Default',
    description: 'Default channel for notifications',
    importance: Importance.high,
  );

  static bool _initialized = false;

  /// Initializes the plugin and creates the notification channel.
  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    // Updated: Add permission request options for iOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true, // Request alert permission
      requestBadgePermission: true, // Request badge permission
      requestSoundPermission: true, // Request sound permission
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(initSettings);

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    // New: Request iOS notification permissions
    await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Displays a rich, styled system notification.
  static Future<void> show({
    required String title,
    required String body,
  }) async {
    var bigTextStyle = BigTextStyleInformation(
      '',
      contentTitle: title,
      summaryText: 'Tap to open the app',
    );

    var androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'Default channel for notifications',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigTextStyle,
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      icon: '@mipmap/ic_launcher',
      color: lightPrimaryColor, // Optional: blue highlight
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(0, title, body, notificationDetails);
  }
}
