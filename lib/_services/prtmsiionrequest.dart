import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermissionIfNeeded() async {
  if (Platform.isAndroid) {
    final androidVersion =
        int.parse(Platform.version.split(" ")[0].split(".")[0]);
    if (androidVersion >= 13) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        final result = await Permission.notification.request();
        if (result.isGranted) {
          debugPrint("✅ Notification permission granted (runtime)");
        } else {
          debugPrint("❌ Notification permission denied (runtime)");
        }
      } else {
        debugPrint("✅ Notification permission already granted");
      }
    }
  }
}
