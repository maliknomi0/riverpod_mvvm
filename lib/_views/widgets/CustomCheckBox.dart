import 'package:flutter/material.dart';
import 'package:zene/themes/theme_constants.dart';

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
        duration: Duration(milliseconds: 230),
        curve: Curves.easeInOut,
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          color: isActive ? selectedColor ?? greyColor : Colors.transparent,
          border: Border.all(
            width: 1.0,
            color:
                isActive
                    ? unSelectedColor ?? greyColor
                    : unSelectedColor ?? lightPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(iscircle == true ? 50 : 5),
        ),
        child:
            !isActive
                ? SizedBox()
                : Icon(
                  Icons.check,
                  size: 11,
                  color: isActive == true ? whiteColor : Colors.transparent,
                ),
      ),
    );
  }
}
