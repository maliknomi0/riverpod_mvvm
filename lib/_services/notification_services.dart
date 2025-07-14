// fcm_service.dart

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:riverpordmvvm/_services/app_services.dart';
import 'package:riverpordmvvm/_services/StorageService.dart';
import 'package:riverpordmvvm/_services/prtmsiionrequest.dart';
import 'package:riverpordmvvm/global/globle.dart';

class FCMService {
  final AppService _apiService = AppService();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final StorageService _storage = StorageService();

  static bool _initialized = false;

  Future<void> initializeAndSendToken() async {
    if (_initialized) return;
    _initialized = true;

    await requestNotificationPermissionIfNeeded();
    final user = await _storage.getLogin();
    if (user != null) {
      userSD = user;
    }

    final allowNotifications = userSD?.allowNotification ?? true;
    if (!allowNotifications) return;

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      debugPrint('🔕 Push notification permission not granted');
      return;
    }

    final token = await _messaging.getToken();
    debugPrint('🔔 Current FCM Token: $token');

    if (token != null && token != userSD?.fcmToken) {
      await _updateLocalToken(token);
      try {
        final response = await _apiService.fcmtokken({'fcmToken': token});
        if (response?['message'] == 'User updated successfully') {
          debugPrint('✅ FCM token updated on server');
        }
      } catch (e) {
        debugPrint('🔴 Error updating FCM token: $e');
      }
    }

    _messaging.onTokenRefresh.listen((newToken) async {
      debugPrint('🔄 FCM Token refreshed: $newToken');
      if (newToken != userSD?.fcmToken) {
        await _updateLocalToken(newToken);
        await _apiService.fcmtokken({'fcmToken': newToken});
      }
    });
  }

  Future<void> _updateLocalToken(String newToken) async {
    userSD = userSD?.copyWith(fcmToken: newToken);
    if (userSD != null) {
      await _storage.setLogin(userSD!);
    }
  }
}
