import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildSlideTransition(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
    transitionDuration: const Duration(milliseconds: 400),
  );
}
