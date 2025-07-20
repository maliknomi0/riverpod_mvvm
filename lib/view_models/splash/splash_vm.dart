import 'package:flutter/material.dart';
import 'package:riverpordmvvm/models/user_model.dart';
import 'package:riverpordmvvm/core/storage/hive_storage_helper.dart';

class SplashVM with ChangeNotifier {
  // Animation Controllers
  late AnimationController logoController;
  late AnimationController headingController;
  late AnimationController descriptionController;

  // Animations
  late Animation<Offset> logoAnimation;
  late Animation<Offset> headingAnimation;
  late Animation<Offset> descriptionAnimation;

  SplashVM({required TickerProvider vsync}) {
    _initAnimations(vsync);
  }

  void _initAnimations(TickerProvider vsync) {
    const duration = Duration(milliseconds: 1200);
    logoController = AnimationController(vsync: vsync, duration: duration);
    headingController = AnimationController(vsync: vsync, duration: duration);
    descriptionController = AnimationController(vsync: vsync, duration: duration);

    logoAnimation = Tween<Offset>(begin: const Offset(0, -3), end: Offset.zero)
        .animate(CurvedAnimation(parent: logoController, curve: Curves.easeInOut));
    headingAnimation = Tween<Offset>(begin: const Offset(-3, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: headingController, curve: Curves.easeInOut));
    descriptionAnimation = Tween<Offset>(begin: const Offset(3, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: descriptionController, curve: Curves.easeInOut));
  }

  Future<void> playAnimations() async {
    await Future.wait([
      logoController.forward().orCancel,
      headingController.forward().orCancel,
      descriptionController.forward().orCancel,
    ]);
  }

  /// Returns initial route based on onboarding, token, and user
  Future<String> getInitialRoute() async {
    final bool seenOnboarding = HiveStorageHelper.isOnboardingComplete();
    if (!seenOnboarding) return '/onboarding';

    final String? token = HiveStorageHelper.getToken();
    final UserModel? user = HiveStorageHelper.getUser();

    if (token != null && token.isNotEmpty && user != null) {
      return '/home';
    } else {
      return '/login';
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
