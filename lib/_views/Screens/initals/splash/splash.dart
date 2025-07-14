import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zene/_Models/user_model.dart';
import 'package:zene/Configs/Assets.dart';
import 'package:zene/services/storage.dart';
import 'package:zene/global/globle.dart' show userSD;
import 'package:zene/_views/Screens/bottom_bar/bottom_bar.dart';
import 'package:zene/_views/Screens/initals/Onbonding/onboarding_screen.dart';
import 'package:zene/_views/Screens/initals/login/login.dart';
import 'package:zene/_views/widgets/common_image.dart';
import 'package:zene/_views/widgets/my_custom_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final Storage _storage = Storage();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Future.delayed(Duration(seconds: 2), () {
      _determineInitialScreen();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _determineInitialScreen() async {
    bool isOnboardingComplete = await _storage.isOnboardingComplete();

    if (!isOnboardingComplete) {
      MyCustomNavigator.removeUntil(context, const OnBoarding());
    } else {
      final String token = await _storage.getToken();
      final dynamic user = await _storage.getLogin();
      if (token.isNotEmpty && user != null) {
        userSD = UserModel.fromJson(user);
        print(userSD);
        MyCustomNavigator.removeUntil(context, BottomNav());
      } else {
        MyCustomNavigator.removeUntil(context, const Login());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo with scaling and opacity effects
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: CommonImageView(
                  height: 76,
                  imagePath:
                      isDarkMode ? AppIamges.Applogo : AppIamges.darkApplogo,
                ),
              ),
            ),
            const SizedBox(height: 14),
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: CommonImageView(
                  height: 52,
                  imagePath:
                      isDarkMode ? AppIamges.urdulogo : AppIamges.darkurdulogo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
