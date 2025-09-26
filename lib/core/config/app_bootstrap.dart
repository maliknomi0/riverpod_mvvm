import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../storage/hive_storage_helper.dart';
import 'localization_config.dart';

class AppBootstrapResult {
  const AppBootstrapResult({required this.locale, this.savedTheme});

  final Locale locale;
  final String? savedTheme;
}

class AppBootstrap {
  const AppBootstrap._();

  static Future<AppBootstrapResult> load() async {
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();
    await HiveStorageHelper.init();

    final savedLocale = HiveStorageHelper.getLocale();
    final savedTheme = HiveStorageHelper.getTheme();

    final locale = savedLocale != null
        ? LocalizationConfig.parseLocale(savedLocale)
        : LocalizationConfig.fallbackLocale;

    return AppBootstrapResult(
      locale: locale,
      savedTheme: savedTheme,
    );
  }
}
