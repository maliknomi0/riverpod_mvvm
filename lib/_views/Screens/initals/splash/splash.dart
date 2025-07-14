import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one/Controller/SplashController.dart';
import 'package:one/_Configs/Assets.dart';
import 'package:one/themes/theme_constants.dart';
import 'package:one/widgets/common_image.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController(vsync: this);
    _handleSplashSequence();
  }

  Future<void> _handleSplashSequence() async {
    try {
      await _controller
          .startAnimations(); // Wait for all animations to complete
      await _controller.navigateToInitialScreen(
        context,
      ); // Navigate after animations
    } catch (e) {
      debugPrint('Splash sequence error: $e');
      if (mounted) {
        _controller.navigateToInitialScreen(context);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<SplashController>(
        builder: (context, controller, child) {
          final isdarkMode = Theme.of(context).brightness == Brightness.dark;
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: controller.logoAnimation,
                    child: CommonImageView(
                      imagePath: AppIamges.Applogo,
                      width: 120,
                      color: isdarkMode ? whiteColor : blackColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SlideTransition(
                    position: controller.headingAnimation,
                    child: Text(
                      'WELCOME TO ONE LIFESTYLE',
                      style: GoogleFonts.anton(
                        fontSize: 28,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SlideTransition(
                    position: controller.descriptionAnimation,
                    child: Text(
                      'One step closer to a better you',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
