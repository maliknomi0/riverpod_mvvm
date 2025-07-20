import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageHelper {
  static const String localeBox = 'locale_box';
  static const String keyLocale = 'locale';

  static const String themeBox = 'theme_box';
  static const String keyTheme = 'theme';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(localeBox);
    await Hive.openBox(themeBox);
  }

  // ----------- Locale -----------
  static Future<void> saveLocale(String locale) async {
    await Hive.box(localeBox).put(keyLocale, locale);
  }

  static String? getLocale() {
    return Hive.box(localeBox).get(keyLocale);
  }

  static Future<void> clearLocale() async {
    await Hive.box(localeBox).delete(keyLocale);
  }

  // ----------- Theme -----------
  static Future<void> saveTheme(String theme) async {
    await Hive.box(themeBox).put(keyTheme, theme);
  }

  static String? getTheme() {
    return Hive.box(themeBox).get(keyTheme);
  }

  static Future<void> clearTheme() async {
    await Hive.box(themeBox).delete(keyTheme);
  }
}
