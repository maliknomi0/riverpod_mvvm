# Flutter Clean MVVM Starter Example (English Version)

This is a **starter template** built with **MVVM + Riverpod + GoRouter +
Clean Code** principles.\
It is fully commented and can be applied to any real-world Flutter
project.

------------------------------------------------------------------------

## Folder Structure

    lib/
    ├── core/
    │   ├── config/
    │   │   ├── theme_config.dart
    │   │   └── localization_config.dart
    │   ├── services/
    │   │   └── storage_service.dart
    │   └── themes/
    │       ├── theme_constants.dart
    │       └── app_themes.dart
    │
    ├── models/
    │   └── user_model.dart
    │
    ├── providers/
    │   ├── locale_provider.dart
    │   ├── theme_provider.dart
    │   └── ... (add more as needed)
    │
    ├── routes/
    │   └── app_router.dart
    │
    ├── views/
    │   ├── splash/
    │   │   ├── splash_screen.dart      // <-- UI
    │   │   └── splash_vm.dart          // <-- Logic (ViewModel)
    │   ├── onboarding/
    │   │   ├── onboarding_screen.dart
    │   │   └── onboarding_vm.dart
    │   ├── login/
    │   │   ├── login_screen.dart
    │   │   └── login_vm.dart
    │   ├── home/
    │   │   ├── home_screen.dart
    │   │   └── home_vm.dart
    │
    ├── widgets/
    │   └── common_image.dart
    │
    └── main.dart

------------------------------------------------------------------------

## Sample Files

### 1. Splash ViewModel (`splash_vm.dart`)

``` dart
import 'package:flutter/material.dart';
import '../../core/services/storage_service.dart';
import '../../models/user_model.dart';

class SplashVM with ChangeNotifier {
  final StorageService _storage = StorageService();
  late AnimationController logoController;

  SplashVM({required TickerProvider vsync}) {
    // Animation setup
  }

  Future<void> playAnimations() async { /* ... */ }

  Future<String> getInitialRoute() async {
    // Onboarding, login, user check logic
    return '/login'; // sample
  }

  @override
  void dispose() { /* ... */ }
}
```

------------------------------------------------------------------------

### 2. Splash UI (`splash_screen.dart`)

``` dart
import 'package:flutter/material.dart';
import 'splash_vm.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget { /* ... */ }

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final SplashVM _vm;
  @override
  void initState() { /* ... */ }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
```

------------------------------------------------------------------------

### 3. GoRouter Setup (`app_router.dart`)

``` dart
import 'package:go_router/go_router.dart';
import '../views/splash/splash_screen.dart';
import '../views/onboarding/onboarding_screen.dart';
import '../views/login/login_screen.dart';
import '../views/home/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => OnboardingScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
  ],
);
```

------------------------------------------------------------------------

### 4. Main Entry (`main.dart`)

``` dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: appRouter,
      // Theme, locale, delegates, etc.
    );
  }
}
```

------------------------------------------------------------------------

### 5. Theme & Localization

-   **`theme_constants.dart`** --- contains global colors, fonts,
    gradients, and text styles.
-   **`app_themes.dart`** --- defines and exports light and dark
    `ThemeData`.
-   **`localization_config.dart`** --- defines supported locales and
    delegates.

------------------------------------------------------------------------

### 6. Riverpod Providers

Each state is handled in `/providers/xyz_provider.dart`, such as: -
Theme provider - Locale provider - Auth provider - etc.

------------------------------------------------------------------------

## Golden Rule

> **"Each feature has its own folder --- inside it, one
> `xyz_screen.dart` (UI) and one `xyz_vm.dart` (logic / ViewModel)."**
>
> -   Route management via `app_router.dart`
> -   Theme, locale, and configurations inside `/core/config`
> -   Riverpod providers inside `/providers`
> -   Shared widgets inside `/widgets`

------------------------------------------------------------------------

## Setup Steps

1.  Prepare the **folder structure**
2.  Create a **screen** and **viewmodel** for each feature
3.  Keep **routing, theme, and localization** in `/core/config`
4.  Manage **state** with Riverpod in `/providers`
5.  Add reusable widgets in `/widgets`

------------------------------------------------------------------------

### Result

Clean, scalable, testable, and team-friendly Flutter project!\
Any new developer can join and understand it immediately.
