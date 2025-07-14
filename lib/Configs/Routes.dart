import 'package:flutter/material.dart';
import 'package:riverpordmvvm/_views/Screens/initals/Onbonding/onboarding_screen.dart';
import 'package:riverpordmvvm/_views/Screens/initals/splash/splash.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String chatlist = '/chatlist';
  static const String userlist = '/userlist';
  static const String addres = '/Address';
  static const String newaddres = '/Newaddress';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const Splash(),
    onboarding: (context) => const OnBoarding(),
  };
}
