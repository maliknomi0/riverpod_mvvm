import 'package:go_router/go_router.dart';
import 'package:riverpordmvvm/main.dart';
import 'package:riverpordmvvm/routes/route_helpers.dart';
import 'package:riverpordmvvm/views/login/login_screen.dart';
import 'package:riverpordmvvm/views/onboarding/onboarding_screen.dart';

import '../views/splash/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) =>
          buildSlideTransition(const SplashScreen()),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) =>
          buildSlideTransition(const OnboardingScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          buildSlideTransition(const LoginScreen()),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => buildSlideTransition(const HomePage()),
    ),
    // baqi routes...
  ],
);
