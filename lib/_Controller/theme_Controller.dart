import 'package:flutter/material.dart';

import '../_services/StorageService.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeController() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final storedTheme = await StorageService().getThemeMode();
    _themeMode = storedTheme;
    notifyListeners();
  }

  void updateTheme(ThemeMode mode) {
    _themeMode = mode;
    StorageService().saveThemeMode(mode);
    notifyListeners();
  }
}
