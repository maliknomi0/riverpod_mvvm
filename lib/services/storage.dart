import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zene/global/globle.dart';

class Storage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static const String _onboardingKey = 'onboarding_complete';
  static const String _languageKey = 'selected_language';

  /// **🔹 Set onboarding as complete**
  Future<void> setOnboardingComplete() async {
    await _secureStorage.write(key: _onboardingKey, value: 'true');
  }

  /// **🔹 Check if onboarding is complete**
  Future<bool> isOnboardingComplete() async {
    final value = await _secureStorage.read(key: _onboardingKey);
    return value == 'true';
  }

  /// **🔹 Save user login data**
  Future<bool> setLogin(dynamic data) async {
    await _storage.write(key: 'user', value: jsonEncode(data));
    return true;
  }

  /// **🔹 Retrieve user login data**
  Future<dynamic> getLogin() async {
    String? value = await _storage.read(key: 'user');
    if (value != null) {
      return jsonDecode(value);
    }
    return null;
  }

  /// **🔹 Save auth token**
  Future<bool> setToken(String token) async {
    await _storage.write(key: 'token', value: token);
    return true;
  }

  /// **🔹 Retrieve auth token**
  Future<String> getToken() async {
    return await _storage.read(key: 'token') ?? '';
  }

  /// **🔹 Logout: Clear all stored data**
  Future<bool> logout() async {
    await _storage.deleteAll();
    userSD = null;
    return true;
  }

  /// **🔹 Save selected theme mode**
  Future<void> saveThemeMode(ThemeMode mode) async {
    await _storage.write(key: 'themeMode', value: mode.toString());
  }

  /// **🔹 Retrieve selected theme mode**
  Future<ThemeMode?> getThemeMode() async {
    final mode = await _storage.read(key: 'themeMode');
    switch (mode) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Save selected language
  Future<void> saveLanguage(String languageCode) async {
    await _storage.write(key: _languageKey, value: languageCode);
  }

  /// Retrieve saved language (Default: English)
  Future<String> getLanguage() async {
    return await _storage.read(key: _languageKey) ?? 'en';
  }
}
