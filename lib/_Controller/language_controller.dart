import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:riverpordmvvm/_services/StorageService.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale;
  final StorageService _storage = StorageService();

  Locale get locale => _locale;

  LocaleProvider({required Locale initialLocale}) : _locale = initialLocale;

  Future<void> setLocale(
    Locale locale, {
    BuildContext? context,
  }) async {
    if (_locale != locale) {
      _locale = locale;
      await _storage.saveLanguage(locale.languageCode);
      if (context != null) {
        await context.setLocale(locale);
      }
      notifyListeners();
    }
  }
}
