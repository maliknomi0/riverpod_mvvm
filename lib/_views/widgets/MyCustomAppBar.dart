import 'package:flutter/material.dart';
import 'package:zene/Configs/Assets.dart';
import 'package:zene/themes/theme_constants.dart';
import 'package:zene/_views/Screens/profile/wishlist/wishlist.dart';
import 'package:zene/_views/widgets/common_image.dart';
import 'package:zene/_views/widgets/my_custom_navigator.dart';

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
                onTap: () {
                  MyCustomNavigator.push(context, const Wishlist());
                },
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
