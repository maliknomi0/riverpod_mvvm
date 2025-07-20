import 'package:go_router/go_router.dart';
import 'package:riverpordmvvm/_views/Screens/initals/login/login.dart';
import 'package:riverpordmvvm/main.dart';

import 'route_helpers.dart'; // import helper

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => buildSlideTransition(HomePage()),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => buildSlideTransition(Login()),
    ),
    // GoRoute(
    //   path: '/profile/:userId',
    //   name: 'profile',
    //   pageBuilder: (context, state) => buildSlideTransition(
    //       ProfilePage(userId: state.params['userId']!)),
    // ),
    // ...more routes
  ],
);
