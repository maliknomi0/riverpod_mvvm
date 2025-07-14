import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zene/Configs/Routes.dart';
import 'package:zene/_Controller/DeleteAccountController.dart';
import 'package:zene/_Controller/EditProfileController.dart';
import 'package:zene/_Controller/ForgetPasswordController.dart';
import 'package:zene/_Controller/Login_controller.dart';
import 'package:zene/_Controller/bottom_nav_controller.dart';
import 'package:zene/_Controller/cars_controller.dart';
import 'package:zene/_Controller/experienceController.dart';
import 'package:zene/_Controller/jets_controller.dart';
import 'package:zene/_Controller/language_controller.dart';
import 'package:zene/_Controller/properties_controller.dart';
import 'package:zene/_Controller/services_controllers.dart';
import 'package:zene/_Controller/shopping_controllers.dart';
import 'package:zene/_Controller/signup_controller.dart';
import 'package:zene/_Controller/transport_booking_controller.dart';
import 'package:zene/_Controller/yatchs_controllers.dart';
import 'package:zene/services/storage.dart';

import '_Controller/theme_Controller.dart';
import 'themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Storage storage = Storage();
  String savedLanguage = await storage.getLanguage();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ur'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(savedLanguage),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeController()),
          ChangeNotifierProvider(create: (_) => SignupController()),
          ChangeNotifierProvider(create: (_) => LoginController()),
          ChangeNotifierProvider(create: (_) => PasswordResetController()),
          ChangeNotifierProvider(create: (_) => EditProfileController()),
          ChangeNotifierProvider(create: (_) => DeleteAccountController()),
          ChangeNotifierProvider(create: (_) => BottomNavController()),
          ChangeNotifierProvider(create: (_) => CarsController()),
          ChangeNotifierProvider(create: (_) => JetsController()),
          ChangeNotifierProvider(create: (_) => ShoppingController()),
          ChangeNotifierProvider(create: (_) => ExperienceController()),
          ChangeNotifierProvider(create: (_) => PropertiesController()),
          ChangeNotifierProvider(create: (_) => YachtsController()),
          ChangeNotifierProvider(create: (_) => ServiceController()),
          ChangeNotifierProvider(create: (_) => TransportBookingController()),
          Provider<Storage>(create: (context) => Storage()), // Storage
          ChangeNotifierProvider(
            create: (_) => LocaleProvider(initialLocale: Locale(savedLanguage)),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeController>(context).themeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      title: 'Zene',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeMode,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
