import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zene/_Controller/language_controller.dart'; // LocaleProvider
import 'package:zene/_Controller/theme_Controller.dart';
import 'package:zene/themes/theme_constants.dart';
import 'package:zene/_views/Screens/language_selection_page.dart';

class LanguageBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;

  const LanguageBar({super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<LanguageBar> createState() => _LanguageBarState();
}

class _LanguageBarState extends State<LanguageBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale;

    final themeMode = context.watch<ThemeController>().themeMode;
    final systemIsDark = Theme.of(context).brightness == Brightness.dark;

    // Determine actual dark mode status
    final isDarkMode =
        themeMode == ThemeMode.system
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
                      position: Tween(
                        begin: Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(parent: animation, curve: Curves.ease),
                      ),
                      child: child,
                    );
                  },
                ),
              );
              // Locale is handled by provider + easy_localization; no need to await or manually update.
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
