import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/_views/Screens/language_selection_page.dart';
import 'package:riverpordmvvm/providers.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class LanguageBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final String? title;

  const LanguageBar({super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  ConsumerState<LanguageBar> createState() => _LanguageBarState();
}

class _LanguageBarState extends ConsumerState<LanguageBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localeProv = ref.watch(localeProvider);
    final currentLocale = localeProv.locale;

    final themeMode = ref.watch(themeControllerProvider).themeMode;
    final systemIsDark = Theme.of(context).brightness == Brightness.dark;

    // Determine actual dark mode status
    final isDarkMode = themeMode == ThemeMode.system
        ? systemIsDark
        : themeMode == ThemeMode.dark;

    return AppBar(
      title: widget.title != null ? Text(widget.title!.tr()) : null,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => LanguageSelectionPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                          .animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.ease,
                            ),
                          ),
                      child: child,
                    );
                  },
                ),
              );
              // Locale is handled by Riverpod + easy_localization; no need to await or manually update.
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isDarkMode ? whiteColor : blackColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    currentLocale.languageCode.toUpperCase(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
