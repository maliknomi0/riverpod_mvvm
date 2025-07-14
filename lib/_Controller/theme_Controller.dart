import 'package:flutter/material.dart';

import '../services/storage.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeController() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final storedTheme = await Storage().getThemeMode();
    _themeMode = storedTheme ?? ThemeMode.system;
    notifyListeners();
  }

  void updateTheme(ThemeMode mode) {
    _themeMode = mode;
    Storage().saveThemeMode(mode);
    notifyListeners();
  }
}
