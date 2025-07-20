import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/config/theme_config.dart';
import '../core/storage/hive_storage_helper.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier({String? savedTheme})
      : super(_getInitialTheme(savedTheme));

  static ThemeMode _getInitialTheme([String? saved]) {
    if (saved == null) {
      final theme = HiveStorageHelper.getTheme();
      if (theme == null) return ThemeMode.light;
      final mode = AppThemeModeExtension.fromString(theme);
      return mode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
    } else {
      final mode = AppThemeModeExtension.fromString(saved);
      return mode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void changeTheme(AppThemeMode mode) async {
    state = mode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
    await HiveStorageHelper.saveTheme(mode.name);
  }
}
