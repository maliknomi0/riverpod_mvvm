import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpordmvvm/core/config/assets_images.dart';
import 'package:riverpordmvvm/view_models/splash/splash_vm.dart';

import '../../core/themes/theme_constants.dart';
import '../../widgets/common_image.dart';
import '../../widgets/my_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final SplashVM _vm;

  @override
  void initState() {
    super.initState();
    _vm = SplashVM(vsync: this);
    _runSplash();
  }

  Future<void> _runSplash() async {
    try {
      await _vm.playAnimations();
      final route = await _vm.getInitialRoute();
      if (!mounted) return;
      context.go(route);
    } catch (e) {
      debugPrint('Splash error: $e');
      if (mounted) context.go('/login');
    }
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _vm.logoAnimation,
              child: CommonImageView(
                imagePath: AppImages.AppLogo,
                width: 120.w, // Responsive
                color: isDark ? whiteColor : blackColor,
              ),
            ),
            SizedBox(height: 30.h), // Responsive
            SlideTransition(
              position: _vm.headingAnimation,
              child: MyText.heading(
                'WELCOME TO ONE LIFESTYLE',
                translate: false,
              ),
            ),
            SizedBox(height: 10.h), // Responsive
            SlideTransition(
              position: _vm.descriptionAnimation,
              child: MyText(
                'One step closer to a better you',
                size: fontSizeS,
                translate: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
