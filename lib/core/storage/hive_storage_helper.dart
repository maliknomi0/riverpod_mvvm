import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpordmvvm/models/user_model.dart';

class HiveStorageHelper {
  // -------------------- Box Names --------------------
  static const String localeBox = 'locale_box';
  static const String themeBox = 'theme_box';
  static const String onboardingBox = 'onboarding_box';
  static const String authBox = 'auth_box'; // <-- NEW

  // -------------------- Keys --------------------
  static const String keyLocale = 'locale';
  static const String keyTheme = 'theme';
  static const String keyOnboarding = 'onboarding_complete';
  static const String keyToken = 'token'; // <-- NEW
  static const String keyUser = 'user'; // <-- NEW

  // -------------------- Init Hive --------------------
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(localeBox);
    await Hive.openBox(themeBox);
    await Hive.openBox(onboardingBox);
    await Hive.openBox(authBox); // <-- NEW
  }

  // -------------------- Locale Methods --------------------
  static Future<void> saveLocale(String locale) async {
    await Hive.box(localeBox).put(keyLocale, locale);
  }

  static String? getLocale() {
    return Hive.box(localeBox).get(keyLocale);
  }

  static Future<void> clearLocale() async {
    await Hive.box(localeBox).delete(keyLocale);
  }

  // -------------------- Theme Methods --------------------
  static Future<void> saveTheme(String theme) async {
    await Hive.box(themeBox).put(keyTheme, theme);
  }

  static String? getTheme() {
    return Hive.box(themeBox).get(keyTheme);
  }

  static Future<void> clearTheme() async {
    await Hive.box(themeBox).delete(keyTheme);
  }

  // -------------------- Onboarding Methods --------------------
  static Future<void> setOnboardingComplete() async {
    await Hive.box(onboardingBox).put(keyOnboarding, true);
  }

  static bool isOnboardingComplete() {
    return Hive.box(onboardingBox).get(keyOnboarding, defaultValue: false) ??
        false;
  }

  static Future<void> clearOnboarding() async {
    await Hive.box(onboardingBox).delete(keyOnboarding);
  }

  // ----------- Token -----------
  static Future<void> saveToken(String token) async {
    await Hive.box(authBox).put(keyToken, token);
  }

  static String getToken() {
    return Hive.box(authBox).get(keyToken, defaultValue: '') ?? '';
  }

  static Future<void> clearToken() async {
    await Hive.box(authBox).delete(keyToken);
  }

  // ----------- User -----------
  static Future<void> saveUser(UserModel user) async {
    await Hive.box(authBox).put(keyUser, user.toJson());
  }

  static UserModel? getUser() {
    final data = Hive.box(authBox).get(keyUser);
    if (data != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static Future<void> clearUser() async {
    await Hive.box(authBox).delete(keyUser);
  }

  // -------------------- Clear Auth (Optional) --------------------
  static Future<void> clearAuth() async {
    await Hive.box(authBox).clear();
  }

  // -------------------- Clear All Data (Optional) --------------------
  static Future<void> clearAll() async {
    await Hive.box(localeBox).clear();
    await Hive.box(themeBox).clear();
    await Hive.box(onboardingBox).clear();
    await Hive.box(authBox).clear();
  }
}
