import 'package:flutter/material.dart';
import 'package:riverpordmvvm/core/themes/theme_constants.dart';
import 'package:toastification/toastification.dart';

class mysnackbar {
  mysnackbar(BuildContext context, String s);

  // Show Success Snackbar
  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      closeIconColor: Colors.black,
    );
  }

  // Show Error Snackbar
  static void showError(BuildContext context, String message) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.red,
      icon: Icons.error,
      closeIconColor: Colors.black,
    );
  }

  // Show Warning Snackbar
  static void showWarning(BuildContext context, String message) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
      closeIconColor: Colors.black,
    );
  }

  // Show Info Snackbar
  static void showInfo(BuildContext context, String message) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
      closeIconColor: Colors.black,
    );
  }

  // Private method to show the styled Snackbar
  static void _showSnackbar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
    Color closeIconColor = whiteColor,
  }) {
    // Map backgroundColor to ToastificationType
    ToastificationType type;
    if (backgroundColor == Colors.green) {
      type = ToastificationType.success;
    } else if (backgroundColor == Colors.red) {
      type = ToastificationType.error;
    } else if (backgroundColor == Colors.orange) {
      type = ToastificationType.warning;
    } else {
      type = ToastificationType.info;
    }

    if (context.mounted) {
      final animationController = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: Navigator.of(context).overlay as TickerProvider,
      );

      final progressAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.linear,
        ),
      );

      // Start the animation immediately
      animationController.forward();

      // Dispose after animation completes
      animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.dispose();
        }
      });

      toastification.show(
        context: context,
        type: type,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: BorderRadius.circular(12),
        backgroundColor: darkBackgroundColor,
        foregroundColor: Colors.black,
        primaryColor: darkBackgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 16,
            offset: Offset(0, 16),
            spreadRadius: 0,
          ),
        ],
        icon: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.6),
              blurRadius: 70.0,
              spreadRadius: 60.0,
            ),
          ]),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        showIcon: true,
        title: Text(
          message,
          style: const TextStyle(
            color: whiteColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        description: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AnimatedBuilder(
            animation: progressAnimation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: progressAnimation.value,
                backgroundColor: Colors.grey.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
                minHeight: 4.0,
              );
            },
          ),
        ),
        showProgressBar: false,
        animationDuration: const Duration(milliseconds: 300),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        applyBlurEffect: true,
        closeButton: ToastCloseButton(
          showType: CloseButtonShowType.onHover,
          buttonBuilder: (context, onClose) {
            return OutlinedButton.icon(
              onPressed: onClose,
              icon: Icon(
                Icons.close,
                size: 20,
                color: closeIconColor,
              ),
              label: const Text('Close'),
            );
          },
        ),
      );
    }
  }
}
