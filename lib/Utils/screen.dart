import 'package:flutter/material.dart';

late double screenWidth;
late double screenHeight;

void initScreenDimensions(BuildContext context) {
  final size = MediaQuery.of(context).size;
  screenWidth = size.width;
  screenHeight = size.height;
}
