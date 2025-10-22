import 'package:go_router/go_router.dart';

import '../views/home/home_screen.dart';
import '../views/login/login_screen.dart';
import '../views/onboarding/onboarding_screen.dart';
import '../views/splash/splash_screen.dart';
import 'route_helpers.dart';

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
      pageBuilder: (context, state) =>
          buildSlideTransition(const HomeScreen()),
    ),
  ],
);
