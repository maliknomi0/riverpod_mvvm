import 'package:go_router/go_router.dart';
import 'package:riverpordmvvm/main.dart';
import 'package:riverpordmvvm/views/login/login_screen.dart';
import 'package:riverpordmvvm/views/onboarding/onboarding_screen.dart';

import '../views/splash/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    // baqi routes...
  ],
);
