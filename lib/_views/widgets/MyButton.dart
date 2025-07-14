import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/_views/widgets/MyText.dart';
import 'package:riverpordmvvm/providers.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

import 'common_image.dart';

class MyButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double? height, width;
  final double radius;
  final double fontSize;
  final Color outlineColor;
  final bool? hasIcon, isLeft, hasShadow, hasGradient;
  final Color? backgroundColor, fontColor;
  final String? svgIcon, choiceIcon;
  final bool haveSvg;
  final double marginTop, marginBottom, marginHorizontal;
  final FontWeight fontWeight;

  const MyButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.height = 48,
    this.backgroundColor,
    this.fontColor = whiteColor,
    this.fontSize = 14,
    this.outlineColor = Colors.transparent,
    this.radius = 20,
    this.svgIcon,
    this.haveSvg = false,
    this.choiceIcon,
    this.isLeft,
    this.marginHorizontal = 0,
    this.hasIcon,
    this.width = double.infinity,
    this.hasShadow = false,
    this.marginBottom = 0,
    this.hasGradient = false,
    this.marginTop = 0,
    this.fontWeight = FontWeight.w400,
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeControllerProvider).themeMode;
        final systemIsDark = Theme.of(context).brightness == Brightness.dark;

        final isDarkMode = themeMode == ThemeMode.system
            ? systemIsDark
            : themeMode == ThemeMode.dark;

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: opacity,
          child: Bounce(
            duration: const Duration(milliseconds: 100),
            onPressed: widget.onTap,
            child: Container(
              margin: EdgeInsets.only(
                top: widget.marginTop,
                bottom: widget.marginBottom,
                left: widget.marginHorizontal,
                right: widget.marginHorizontal,
              ),
              height: widget.height,
              width: widget.width,
              decoration: widget.hasGradient == true
                  ? BoxDecoration(
                      gradient: lightAppGradiant,
                      border: Border.all(color: widget.outlineColor),
                      borderRadius: BorderRadius.circular(widget.radius),
                    )
                  : BoxDecoration(
                      color:
                          widget.backgroundColor ??
                          (isDarkMode ? greyColor : whiteColor),
                      border: Border.all(color: blackColor),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
              child: Material(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: widget.isLeft == true
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    if (widget.hasIcon == true)
                      Padding(
                        padding: widget.isLeft == true
                            ? const EdgeInsets.only(left: 20.0)
                            : const EdgeInsets.only(left: 0),
                        child: CommonImageView(
                          imagePath: widget.choiceIcon,
                          height: 20,
                        ),
                      ),
                    MyText(
                      paddingLeft: (widget.hasIcon == true) ? 10 : 0,
                      widget.buttonText.tr(),
                      size: widget.fontSize,
                      color: widget.hasGradient == true
                          ? whiteColor
                          : (isDarkMode ? whiteColor : blackColor),
                      weight: widget.fontWeight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
