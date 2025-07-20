import 'package:flutter/material.dart';
import 'package:riverpordmvvm/core/themes/theme_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({
    super.key,
    required this.isActive,
    required this.onTap,
    this.unSelectedColor,
    this.selectedColor,
    this.iscircle,
  });

  final bool isActive;
  final VoidCallback onTap;
  Color? unSelectedColor, selectedColor;
  bool? iscircle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 230),
        curve: Curves.easeInOut,
        height: 18.h,   // Responsive height
        width: 18.w,    // Responsive width
        decoration: BoxDecoration(
          color: isActive ? selectedColor ?? greyColor : Colors.transparent,
          border: Border.all(
            width: 1.0.w, // Responsive border width (optional)
            color: isActive
                ? unSelectedColor ?? greyColor
                : unSelectedColor ?? lightPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(iscircle == true ? 50.r : 5.r), // Responsive radius
        ),
        child: !isActive
            ? const SizedBox()
            : Icon(
                Icons.check,
                size: 13.sp, // Responsive icon size
                color: isActive == true ? whiteColor : Colors.transparent,
              ),
      ),
    );
  }
}
