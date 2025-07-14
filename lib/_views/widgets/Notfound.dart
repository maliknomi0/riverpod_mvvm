import 'package:flutter/material.dart';
import 'package:zene/themes/theme_constants.dart';
import 'package:zene/_views/widgets/MyText.dart';
import 'package:zene/_views/widgets/common_image.dart';

class NotFoundWidget extends StatelessWidget {
  final String title; // Required title
  final String description; // Required description
  final String imageUrl; // Required image URL

  const NotFoundWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonImageView(
            imagePath: imageUrl,
            width: 150,
            height: 150,
            color: iconColor,
          ),
          const SizedBox(height: 16), // Spacing
          MyText(title, weight: FontWeight.bold, size: 16),
          const SizedBox(height: 8), // Spacing
          MyText(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
