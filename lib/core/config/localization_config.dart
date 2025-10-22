import 'package:flutter/material.dart';

class LocalizationConfig {
  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
    Locale('ar', 'SA'),
  ];

  static const fallbackLocale = Locale('en', 'US');
  static const path = 'assets/translations';

  static Locale parseLocale(String value) {
    final parts = value.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }
}
