enum AppThemeMode {
  light,
  dark,
}

extension AppThemeModeExtension on AppThemeMode {
  String get name => toString().split('.').last;

  static AppThemeMode fromString(String value) {
    return AppThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AppThemeMode.light,
    );
  }
}
