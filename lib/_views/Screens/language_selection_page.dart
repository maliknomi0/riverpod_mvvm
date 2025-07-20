import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/core/themes/theme_constants.dart';
import 'package:riverpordmvvm/widgets/MyText.dart';
import '../../providers/localization_provider.dart';

class LanguageSelectionPage extends ConsumerWidget {
  LanguageSelectionPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> languages = [
    {'locale': Locale('en', 'US'), 'label': 'English'},
    {'locale': Locale('ur', 'PK'), 'label': 'اردو'},
    {'locale': Locale('ar', 'SA'), 'label': 'العربية'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text('choose_language').tr()),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          final Locale locale = lang['locale'] as Locale;
          final selected =
              currentLocale.languageCode == locale.languageCode;

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
                // Riverpod
                ref.read(localeProvider.notifier).changeLocale(locale);
                // easy_localization
                await context.setLocale(locale);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
