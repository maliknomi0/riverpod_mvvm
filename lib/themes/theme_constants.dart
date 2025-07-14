import 'package:flutter/material.dart';

// Primary colors for both themes
const Color darkPrimaryColor = Color(0xFFA9A9A9);
const Color lightPrimaryColor = Color(0xFFA9A9A9);

// Background colors
const Color darkBackgroundColor = Color(0xFF0F0F0F);
const Color lightBackgroundColor = Color(0xFFFFFFFF);

// Inactive text field colors
const Color inactiveTextFieldColor = Color(0xFFCBCFD4);

// Define light color scheme
const lightColorScheme = ColorScheme.light(
  brightness: Brightness.light,
  primary: lightPrimaryColor,
  surface: lightBackgroundColor,
  secondary: inactiveTextFieldColor,
);

// Define dark color scheme
const darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,
  primary: darkPrimaryColor,
  surface: darkBackgroundColor,
  secondary: inactiveTextFieldColor,
);

// Additional color constants
const blackColor = Color(0xFF000000);
const whiteColor = Color(0xFFFFFFFF);
const redColor = Color(0xFFD32F2F);
const greyColor = Color(0xFF616161);
const DividerColor = Color(0xff717171);
const TransparentColor = Colors.transparent;
const iconColor = Color(0xFFB0B0B0);

const buttonhight = 48.0;
const p = 16.0;

const lightAppGradiant = LinearGradient(
  colors: [Color(0xff2D2D2D), Color(0xff1E1E1E)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const darkAppGradiant = LinearGradient(
  colors: [whiteColor, whiteColor],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const AppOnBoardingText = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);
const AppAuthHeading = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w300,
  fontFamily: "Blinker",
);
const normalheading = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
  fontFamily: "Blinker",
);
BorderRadius kAppBorderRadius = BorderRadius.circular(15);
