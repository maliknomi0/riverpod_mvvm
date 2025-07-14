import 'package:flutter/material.dart';
import 'package:zene/services/storage.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale;
  final Storage _storage = Storage(); // 🔹 Add this line to initialize storage

  Locale get locale => _locale;

  LocaleProvider({required Locale initialLocale}) : _locale = initialLocale;

  Future<void> setLocale(Locale locale) async {
    if (_locale != locale) {
      _locale = locale;
      await _storage.saveLanguage(
        locale.languageCode,
      ); // use the method from Storage
      notifyListeners();
    }
  }
}
