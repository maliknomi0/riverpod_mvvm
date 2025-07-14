import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/_Controller/language_controller.dart'; // Your LocaleProvider
import 'package:riverpordmvvm/themes/theme_constants.dart';
import 'package:riverpordmvvm/_views/widgets/MyText.dart';

class LanguageSelectionPage extends ConsumerWidget {
  LanguageSelectionPage({super.key});

  final List<Map<String, dynamic>> languages = [
    {'locale': Locale('en'), 'label': 'English'},
    {'locale': Locale('ur'), 'label': 'اردو'},
    {'locale': Locale('ar'), 'label': 'العربية'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeProv = ref.watch(localeProvider);
    final currentLocale = localeProv.locale;

    return Scaffold(
      appBar: AppBar(title: Text('choose_language').tr()),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          final selected =
              currentLocale.languageCode == lang['locale'].languageCode;

          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: selected ? greyColor.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(Icons.language),
              title: MyText(
                lang['label'],
                weight: selected ? FontWeight.bold : FontWeight.normal,
              ),
              trailing: selected
                  ? Icon(Icons.check_circle, color: greyColor)
                  : null,
              onTap: () async {
                final selectedLocale = lang['locale'] as Locale;
                await localeProv.setLocale(selectedLocale);
                await context.setLocale(selectedLocale);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
