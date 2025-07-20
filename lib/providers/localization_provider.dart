import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/storage/hive_storage_helper.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(_getInitialLocale());

  static Locale _getInitialLocale() {
    final String? saved = HiveStorageHelper.getLocale();
    if (saved != null) {
      final parts = saved.split('_');
      return Locale(parts[0], parts.length > 1 ? parts[1] : null);
    }
    return const Locale('en', 'US');
  }

  void changeLocale(Locale locale) async {
    state = locale;
    await HiveStorageHelper.saveLocale(locale.toString());
  }


  Future<void> resetLocale() async {
    await HiveStorageHelper.clearLocale();
    state = const Locale('en', 'US');
  }
}
