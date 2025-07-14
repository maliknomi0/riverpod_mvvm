import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:riverpordmvvm/_Models/user_model.dart';
import 'package:riverpordmvvm/_services/google_sign_in.dart';

/// A singleton service that wraps all Hive storage operations.
class StorageService {
  StorageService._internal();

  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;

  static const String _boxName = 'app_storage';
  static const String _onboardingKey = 'onboarding_complete';
  static const String _languageKey = 'selected_language';

  Box<dynamic>? _box;
  bool _initialized = false;
  final Map<String, Box<dynamic>> _boxes = {};

  /// Initializes Hive box. Call once during app startup.
  Future<void> init({List<int>? encryptionKey}) async {
    if (_initialized) return;
    _box = await Hive.openBox(
      _boxName,
      encryptionCipher:
          encryptionKey != null ? HiveAesCipher(encryptionKey) : null,
    );
    _initialized = true;
  }

  Future<Box<dynamic>> _getBox() async {
    if (!_initialized) {
      await init();
    }
    return _box!;
  }

  /// Opens a Hive box and caches the instance.
  Future<Box<dynamic>> openBox(String name) async {
    if (_boxes.containsKey(name)) return _boxes[name]!;
    final box = await Hive.openBox(name);
    _boxes[name] = box;
    return box;
  }

  /// Deletes the Hive box from disk and cache.
  Future<void> deleteBox(String name) async {
    if (_boxes.containsKey(name)) {
      await _boxes[name]!.deleteFromDisk();
      _boxes.remove(name);
    } else if (Hive.isBoxOpen(name)) {
      final box = Hive.box(name);
      await box.deleteFromDisk();
    } else {
      await Hive.deleteBoxFromDisk(name);
    }
  }

  /// Writes a value for the given [key].
  Future<void> write<T>(String key, T value) async {
    final box = await _getBox();
    await box.put(key, value);
  }

  /// Reads a value for the given [key].
  Future<T?> read<T>(String key) async {
    final box = await _getBox();
    return box.get(key) as T?;
  }

  /// Deletes the value associated with the [key].
  Future<void> delete(String key) async {
    final box = await _getBox();
    await box.delete(key);
  }

  /// Checks if the [key] exists in storage.
  Future<bool> containsKey(String key) async {
    final box = await _getBox();
    return box.containsKey(key);
  }

  /// Clears all data from storage.
  Future<void> clearAll() async {
    final box = await _getBox();
    await box.clear();
  }

  /// Saves user login data.
  Future<void> setLogin(UserModel user) async {
    await write('user', jsonEncode(user.toJson()));
  }

  /// Retrieves stored user data.
  Future<UserModel?> getLogin() async {
    final data = await read<String>('user');
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  /// Saves authentication token.
  Future<void> setToken(String token) async => write('token', token);

  /// Retrieves authentication token.
  Future<String> getToken() async => (await read<String>('token')) ?? '';

  /// Saves onboarding completion flag.
  Future<void> setOnboardingComplete() async => write(_onboardingKey, true);

  /// Checks if onboarding was completed.
  Future<bool> isOnboardingComplete() async =>
      (await read<bool>(_onboardingKey)) ?? false;

  /// Saves selected theme mode.
  Future<void> saveThemeMode(ThemeMode mode) async =>
      write('themeMode', mode.index);

  /// Retrieves saved theme mode.
  Future<ThemeMode> getThemeMode() async {
    final index = await read<int>('themeMode');
    switch (index) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Saves selected language code.
  Future<void> saveLanguage(String languageCode) async =>
      write(_languageKey, languageCode);

  /// Retrieves saved language code (defaults to 'en').
  Future<String> getLanguage() async =>
      (await read<String>(_languageKey)) ?? 'en';

  /// Logs out the user and wipes all stored data.
  Future<void> logout() async {
    await clearAll();
    final box = await _getBox();
    await box.deleteFromDisk();

    final otherBoxes = [
      'favorite_recipes',
      'nutritionBox',
      'checkInBox',
      'paymentPlansBox',
    ];
    for (final name in otherBoxes) {
      await deleteBox(name);
    }

    _boxes.clear();

    _initialized = false;
    _box = null;
    await GoogleSignInService.logout();
  }
}
