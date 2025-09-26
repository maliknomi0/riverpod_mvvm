import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/localization_config.dart';
import '../../core/config/theme_config.dart';
import '../../providers/localization_provider.dart';
import '../../providers/theme_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('title').tr(),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              final nextMode = themeMode == ThemeMode.light
                  ? AppThemeMode.dark
                  : AppThemeMode.light;
              ref.read(themeProvider.notifier).changeTheme(nextMode);
            },
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('cookies_message').tr(),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: _localeOptions
                  .where(
                    (option) =>
                        LocalizationConfig.supportedLocales.contains(option.locale),
                  )
                  .map(
                    (option) => ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(localeProvider.notifier)
                            .changeLocale(option.locale);
                        await context.setLocale(option.locale);
                      },
                      child: Text(option.label),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await ref.read(localeProvider.notifier).resetLocale();
                await context.setLocale(LocalizationConfig.fallbackLocale);
              },
              child: const Text('Reset Locale'),
            ),
            const SizedBox(height: 24),
            Text(
              'Theme: ' + (themeMode == ThemeMode.light ? 'Light' : 'Dark'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Locale: ' + locale.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocaleOption {
  const _LocaleOption({required this.label, required this.locale});

  final String label;
  final Locale locale;
}

const _localeOptions = [
  _LocaleOption(label: 'English', locale: Locale('en', 'US')),
  _LocaleOption(label: 'اردو', locale: Locale('ur', 'PK')),
  _LocaleOption(label: 'العربية', locale: Locale('ar', 'SA')),
];
