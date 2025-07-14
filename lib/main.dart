import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:riverpordmvvm/Configs/Routes.dart';
import 'package:riverpordmvvm/_Controller/ForgetPasswordController.dart';
import 'package:riverpordmvvm/_Controller/Login_controller.dart';
import 'package:riverpordmvvm/_Controller/signup_controller.dart';
import 'package:riverpordmvvm/_Controller/theme_Controller.dart';

import 'package:riverpordmvvm/_services/StorageService.dart';
import 'package:riverpordmvvm/_services/fcm_handler.dart';
import 'package:riverpordmvvm/_services/notification_services.dart';
import 'package:riverpordmvvm/config.dart';
import 'package:riverpordmvvm/firebase_options.dart';
import 'package:riverpordmvvm/global/globle.dart';

import 'themes/app_themes.dart';

// Handler for background messages from Firebase Messaging
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // You can handle the message here, e.g., show a notification
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Hive.initFlutter();
  StorageService storage = StorageService();
  await storage.init();

  final user = await storage.getLogin();

  if (user != null) {
    userSD = user; // 💾 global user set karo
    await FCMService().initializeAndSendToken(); // 🔐 Token + permission
    await FCMHandler.setupNotificationHandlers(); // 📩 Listener
  }
  String savedLanguage = await storage.getLanguage();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(savedLanguage),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeController()),
          ChangeNotifierProvider(create: (_) => SignupController()),
          ChangeNotifierProvider(create: (_) => LoginController()),
          ChangeNotifierProvider(create: (_) => PasswordResetController()),
                  Provider<StorageService>(create: (context) => StorageService()),
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
      title: '0NE',
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
