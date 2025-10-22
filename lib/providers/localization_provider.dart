import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/localization_config.dart';
import '../core/storage/hive_storage_helper.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier({Locale? initialLocale})
      : super(initialLocale ?? _getInitialLocale());

  static Locale _getInitialLocale() {
    final String? saved = HiveStorageHelper.getLocale();
    if (saved != null) {
      return LocalizationConfig.parseLocale(saved);
    }
    return LocalizationConfig.fallbackLocale;
  }

  Future<void> changeLocale(Locale locale) async {
    state = locale;
    await HiveStorageHelper.saveLocale(locale.toString());
  }

  Future<void> resetLocale() async {
    await HiveStorageHelper.clearLocale();
    state = LocalizationConfig.fallbackLocale;
  }
}
