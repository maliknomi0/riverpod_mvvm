import 'package:flutter/material.dart';
import 'package:riverpordmvvm/_Models/user_model.dart';
import 'package:riverpordmvvm/_services/StorageService.dart';
import 'package:riverpordmvvm/_views/Screens/initals/Onbonding/onboarding_screen.dart';
import 'package:riverpordmvvm/_views/Screens/initals/login/login.dart';
import 'package:riverpordmvvm/widgets/my_custom_navigator.dart';
import 'package:riverpordmvvm/global/globle.dart';

class SplashController extends ChangeNotifier {
  final StorageService _storage = StorageService();
  late AnimationController logoController;
  late AnimationController headingController;
  late AnimationController descriptionController;
  late Animation<Offset> logoAnimation;
  late Animation<Offset> headingAnimation;
  late Animation<Offset> descriptionAnimation;

  SplashController({required TickerProvider vsync}) {
    _initializeAnimations(vsync);
  }

  void _initializeAnimations(TickerProvider vsync) {
    const duration = Duration(
      milliseconds: 2000,
    ); // Reduced from 3 seconds to 1 second

    logoController = AnimationController(vsync: vsync, duration: duration);
    headingController = AnimationController(vsync: vsync, duration: duration);
    descriptionController = AnimationController(
      vsync: vsync,
      duration: duration,
    );

    logoAnimation = Tween<Offset>(
      begin: const Offset(0, -3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: logoController, curve: Curves.easeInOut));

    headingAnimation = Tween<Offset>(
      begin: const Offset(-3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: headingController, curve: Curves.easeInOut),
    );

    descriptionAnimation = Tween<Offset>(
      begin: const Offset(3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: descriptionController, curve: Curves.easeInOut),
    );
  }

  Future<void> startAnimations() async {
    // Start all animations simultaneously and wait for them to finish
    await Future.wait([
      logoController.forward().orCancel,
      headingController.forward().orCancel,
      descriptionController.forward().orCancel,
    ]);
  }

  Future<void> navigateToInitialScreen(BuildContext context) async {
    try {
      final bool seenOnboarding = await _storage.isOnboardingComplete();
      if (!context.mounted) return;

      if (!seenOnboarding) {
        await MyCustomNavigator.push(context, const OnBoarding());
      }
      final token = await _storage.getToken();
      final UserModel? user = await _storage.getLogin();

      if (!context.mounted) return;

      if (token.isNotEmpty && user != null) {
        userSD = user;
        // MyCustomNavigator.removeUntil(context, const BottomBarNav());
      } else {
        MyCustomNavigator.removeUntil(context, const Login());
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
      if (context.mounted) {
        MyCustomNavigator.removeUntil(context, const Login());
      }
    }
  }

  @override
  void dispose() {
    logoController.dispose();
    headingController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
