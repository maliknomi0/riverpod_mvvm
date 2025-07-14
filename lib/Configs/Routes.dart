import 'package:flutter/material.dart';
import 'package:zene/_views/Screens/initals/Onbonding/onboarding_screen.dart';
import 'package:zene/_views/Screens/initals/splash/splash.dart';
import 'package:zene/_views/Screens/profile/Address/address.dart';
import 'package:zene/_views/Screens/profile/chatlist/chatscreen.dart';
import 'package:zene/_views/Screens/profile/chatlist/userlist.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String chatlist = '/chatlist';
  static const String userlist = '/userlist';
  static const String addres = '/Address';
  static const String newaddres = '/Newaddress';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnBoarding(),
    chatlist:
        (context) =>
            const ChatScreen(image: "user['image']!", name: "user['name']!"),
    userlist: (context) => const chatlistScreen(),
    addres: (context) => const Address(),
  };
}
