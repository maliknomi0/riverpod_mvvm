import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:riverpordmvvm/core/themes/theme_constants.dart';

class MyText extends StatefulWidget {
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final List<Shadow>? shadow;
  final int? maxLines;
  final Paint? paint;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;
  final bool translate;

  const MyText(
    this.text, { // ✅ Now `text` is the first required parameter
    super.key,
    this.size,
    this.lineHeight,
    this.maxLines = 100,
    this.decoration = TextDecoration.none,
    this.color,
    this.paint,
    this.letterSpacing,
    this.weight = FontWeight.w400,
    this.textAlign,
    this.textOverflow,
    this.fontFamily,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.onTap,
    this.shadow,
    this.fontStyle,
    this.translate = true,
  });

  const MyText.heading(
    String text, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    int? maxLines,
    double? lineHeight,
    double paddingTop = 0,
    double paddingLeft = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    double? letterSpacing,
    bool translate = true,
  }) : this(
          text,
          key: key,
          size: headingTextStyle.fontSize,
          weight: headingTextStyle.fontWeight,
          textAlign: textAlign,
          textOverflow: textOverflow,
          maxLines: maxLines,
          lineHeight: lineHeight,
          paddingTop: paddingTop,
          paddingLeft: paddingLeft,
          paddingRight: paddingRight,
          paddingBottom: paddingBottom,
          letterSpacing: letterSpacing,
          translate: translate,
        );

  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: opacity,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.paddingTop!,
          left: widget.paddingLeft!,
          right: widget.paddingRight!,
          bottom: widget.paddingBottom!,
        ),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Text(
            widget.translate ? widget.text.tr() : widget.text,
            style: TextStyle(
              foreground: widget.paint,
              shadows: widget.shadow,
              fontSize: widget.size ?? fontSizeXS,
              color: widget.color ?? appTextColor,
              fontWeight: widget.weight,
              decoration: widget.decoration,
              decorationColor: widget.color ?? appTextColor,
              decorationThickness: 2,
              height: widget.lineHeight,
              fontStyle: widget.fontStyle,
              letterSpacing: widget.letterSpacing ?? 0.5,
            ),
            textAlign: widget.textAlign,
            maxLines: widget.maxLines,
            overflow: widget.textOverflow,
          ),
        ),
      ),
    );
  }
}
