import 'package:flutter/material.dart';

// ----------------------- COLORS -----------------------
const Color primaryColor = Color(0xFF1976D2); // <-- Add this
const Color onPrimaryColor = Colors.white; // <-- Add this
const Color secondaryColor = Color(0xFF64B5F6); // <-- Add this
const Color onSecondaryColor = Colors.black; // <-- Add this
const Color backgroundColor = Color(0xFFF5F5F5); // <-- Add this

const Color darkPrimaryColor = Color(0xFFA9A9A9);
const Color lightPrimaryColor = Color(0xFFA9A9A9);
const Color darkBackgroundColor = Color(0xFF0F0F0F);
const Color lightBackgroundColor = Color(0xFFFFFFFF);
const Color inactiveTextFieldColor = Color(0xFFCBCFD4);
const Color blackColor = Color(0xFF000000);
const Color whiteColor = Color(0xFFFFFFFF);
const Color errorColor = Color(0xFFD32F2F); // <-- Name fixed for ColorScheme
const Color redColor = Color(0xFFD32F2F);
const Color greyColor = Color(0xFF616161);
const Color dividerColor = Color(0xff717171);
const Color transparentColor = Colors.transparent;
const Color iconColor = Color(0xFFB0B0B0);

// ----------------------- SIZES -----------------------
const double buttonHeight = 48.0;
const double appPadding = 16.0;

// ----------------------- GRADIENTS -----------------------
const lightAppGradient = LinearGradient(
  colors: [Color(0xff2D2D2D), Color(0xff1E1E1E)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const darkAppGradient = LinearGradient(
  colors: [whiteColor, whiteColor],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

// ----------------------- BORDERS -----------------------
final BorderRadius kAppBorderRadius = BorderRadius.circular(15);

// ----------------------- FONTS -----------------------
const String fontFamilyPoppins = "Poppins";
const String fontFamilyBlinker = "Blinker";

// Global Font Sizes
const double fontSizeXL = 32;
const double fontSizeL = 24;
const double fontSizeM = 18;
const double fontSizeS = 16;
const double fontSizeXS = 14;
const double fontSizeXXS = 12;

// FontWeight
const FontWeight weightBold = FontWeight.bold;
const FontWeight weightSemiBold = FontWeight.w500;
const FontWeight weightMedium = FontWeight.w400;
const FontWeight weightLight = FontWeight.w300;

// ----------------------- TEXT STYLES (for direct use if needed) -----------------------
const TextStyle appOnBoardingText = TextStyle(
  fontSize: fontSizeXL,
  fontWeight: weightSemiBold,
  fontFamily: fontFamilyPoppins,
);

const TextStyle appAuthHeading = TextStyle(
  fontSize: fontSizeXL,
  fontWeight: weightLight,
  fontFamily: fontFamilyBlinker,
);

const TextStyle normalHeading = TextStyle(
  fontSize: fontSizeM,
  fontWeight: weightLight,
  fontFamily: fontFamilyBlinker,
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: primaryColor,
  onPrimary: onPrimaryColor,
  secondary: secondaryColor,
  onSecondary: onSecondaryColor,
  error: errorColor,
  onError: onPrimaryColor,
  surface: Colors.white,
  onSurface: Colors.black,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: primaryColor,
  onPrimary: onPrimaryColor,
  secondary: secondaryColor,
  onSecondary: onSecondaryColor,
  error: errorColor,
  onError: onPrimaryColor,
  surface: Color(0xFF232323),
  onSurface: Colors.white,
);
