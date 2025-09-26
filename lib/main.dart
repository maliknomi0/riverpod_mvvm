import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/app_bootstrap.dart';
import 'core/config/localization_config.dart';
import 'providers/localization_provider.dart';
import 'providers/theme_provider.dart';
import 'widgets/app_root.dart';

Future<void> main() async {
  final bootstrap = await AppBootstrap.load();

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationConfig.supportedLocales,
      path: LocalizationConfig.path,
      fallbackLocale: LocalizationConfig.fallbackLocale,
      startLocale: bootstrap.locale,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) => ProviderScope(
          overrides: [
            themeProvider.overrideWith(
              (ref) => ThemeNotifier(savedTheme: bootstrap.savedTheme),
            ),
            localeProvider.overrideWith(
              (ref) => LocaleNotifier(initialLocale: bootstrap.locale),
            ),
          ],
          child: child,
        ),
        child: const AppRoot(),
      ),
    ),
  );
}
