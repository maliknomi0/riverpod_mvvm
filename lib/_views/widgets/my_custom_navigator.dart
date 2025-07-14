import 'package:flutter/material.dart';

class MyCustomNavigator {
  /// 🔹 Normal push with slide animation
  static Future<dynamic> push(BuildContext context, Widget page) {
    return Navigator.push(context, _createRoute(page));
  }

  /// 🔹 Replace current screen
  static Future<dynamic> replace(BuildContext context, Widget page) {
    return Navigator.pushReplacement(context, _createRoute(page));
  }

  /// 🔹 Push and remove all previous
  static Future<dynamic> removeUntil(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(context, _createRoute(page), (route) => false);
  }

  /// 🔹 Push until a specific route name is found
  static Future<dynamic> pushUntil(BuildContext context, Widget page, String routeName) {
    return Navigator.pushAndRemoveUntil(
      context,
      _createRoute(page),
      ModalRoute.withName(routeName),
    );
  }

  /// 🔹 Push Named Route
  static Future<dynamic> pushNamed(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  /// 🔹 Replace Named Route
  static Future<dynamic> replaceNamed(BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed(context, routeName);
  }

  /// 🔹 Remove all and go to named route
  static Future<dynamic> removeUntilNamed(BuildContext context, String routeName) {
    return Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  /// 🔹 Pop current screen
  static void pop(BuildContext context, [dynamic result]) {
    Navigator.pop(context, result);
  }

  /// 🔹 Pop until a specific route name
  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  /// 🔸 Common Slide Animation Route Builder
  static Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Slide from right
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}