import 'package:flutter/material.dart';
import 'package:riverpordmvvm/Configs/Assets.dart';
import 'package:riverpordmvvm/_views/widgets/common_image.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class MyCustomAppBar extends StatelessWidget {
  const MyCustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonImageView(
            imagePath: isDarkMode ? AppIamges.Applogo : AppIamges.darkApplogo,
            width: 100,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: CommonImageView(
                  imagePath: AppIamges.iconsfav,
                  color: iconColor,
                  height: 20,
                ),
              ),
              SizedBox(width: 12),
              CommonImageView(
                imagePath: AppIamges.iconsbell,
                color: iconColor,
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
