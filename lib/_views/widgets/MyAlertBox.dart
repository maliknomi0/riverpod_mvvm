import 'package:flutter/material.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class MyAlertBox extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;
  final Color? cancelColor;

  const MyAlertBox({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.onConfirm,
    this.onCancel,
    this.confirmColor,
    this.cancelColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppAuthHeading),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.pop(context),
          child: Text(cancelText, style: TextStyle(color: cancelColor)),
        ),
        TextButton(
          onPressed: onConfirm ?? () => Navigator.pop(context),
          child: Text(
            confirmText,
            style: TextStyle(color: confirmColor ?? redColor),
          ),
        ),
      ],
    );
  }
}
