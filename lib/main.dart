import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpordmvvm/core/config/theme_config.dart';
import 'package:riverpordmvvm/routes/app_router.dart';

import 'core/config/localization_config.dart';
import 'core/storage/hive_storage_helper.dart';
import 'core/themes/app_themes.dart';
import 'providers/localization_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await HiveStorageHelper.init();

  // Locale: check saved value
  final String? savedLocale = HiveStorageHelper.getLocale();
  final Locale startLocale = savedLocale != null
      ? _toLocale(savedLocale)
      : LocalizationConfig.fallbackLocale;

  // Theme: check saved value
  final String? savedTheme = HiveStorageHelper.getTheme();

  runApp(
        EasyLocalization(
      supportedLocales: LocalizationConfig.supportedLocales,
      path: LocalizationConfig.path,
      fallbackLocale: LocalizationConfig.fallbackLocale,
      startLocale: startLocale,
      child: ScreenUtilInit(
        designSize: Size(375, 812), // <-- yahan apni design size likho
        minTextAdapt: true,
        builder: (context, child) => ProviderScope(
          overrides: [
            themeProvider.overrideWith(
              (ref) => ThemeNotifier(savedTheme: savedTheme),
            ),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

Locale _toLocale(String value) {
  final parts = value.split('_');
  return Locale(parts[0], parts.length > 1 ? parts[1] : null);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Your App",
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routerConfig: appRouter, // <-- Yeh line use karo!
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('title').tr(),
        actions: [
          // Theme switch
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              ref
                  .read(themeProvider.notifier)
                  .changeTheme(
                    themeMode == ThemeMode.light
                        ? AppThemeMode.dark
                        : AppThemeMode.light,
                  );
            },
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('cookies_message').tr(),
            SizedBox(height: 24),

            // Language Switcher Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(localeProvider.notifier)
                        .changeLocale(Locale('en', 'US'));
                    context.setLocale(Locale('en', 'US'));
                  },
                  child: Text('English'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(localeProvider.notifier)
                        .changeLocale(Locale('ur', 'PK'));
                    context.setLocale(Locale('ur', 'PK'));
                  },
                  child: Text('اردو'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(localeProvider.notifier)
                        .changeLocale(Locale('ar', 'SA'));
                    context.setLocale(Locale('ar', 'SA'));
                  },
                  child: Text('العربية'),
                ),
              ],
            ),
            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                ref.read(localeProvider.notifier).resetLocale();
                context.setLocale(Locale('en', 'US'));
              },
              child: Text('Reset Locale'),
            ),

            SizedBox(height: 24),
            // Theme status for test
            Text(
              'Theme: ${themeMode == ThemeMode.light ? "Light" : "Dark"}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Locale: ${locale.toString()}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
