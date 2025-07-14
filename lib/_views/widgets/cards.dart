import 'package:flutter/material.dart';
import 'package:zene/Utils/formate.dart';
import 'package:zene/config.dart';
import 'package:zene/themes/theme_constants.dart';
import 'package:zene/_views/widgets/MyContainer.dart';
import 'package:zene/_views/widgets/MyText.dart';
import 'package:zene/_views/widgets/common_image.dart';

class myCard extends StatelessWidget {
  final dynamic product; // Product data (can be null for placeholder)
  final double? width; // Customizable width (optional)
  final double? height; // Customizable height (optional)
  final double radius; // Customizable border radius
  final Color backgroundColor; // Customizable background color
  final VoidCallback? onTap; // Optional custom tap action (no default)
  final bool hasGradient; // Toggle gradient
  final Gradient? customGradient; // Custom gradient option
  // Optional extra lines
  final String? extraLine1; // e.g., Description
  final String? extraLine2; // e.g., Stock status
  final String? extraLine3; // e.g., Another detail

  const myCard({
    super.key,
    this.product,
    this.width,
    this.height,
    this.radius = 10,
    this.backgroundColor = const Color(0xFF212121), // Default grey[900]
    this.onTap, // No default behavior
    this.hasGradient = false,
    this.customGradient,
    this.extraLine1,
    this.extraLine2,
    this.extraLine3,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final defaultWidth = width ?? (screenWidth < 400 ? 150.0 : 160.0);

    final displayCategory = product?.category ?? "Category";
    final displayTitle = product?.title ?? "Product Title";
    final displayPrice =
        product?.finalPrice != null
            ? "AED ${formatPrice(product.finalPrice)}"
            : "AED 0.00";
    final imageUrl =
        product != null && product.images.isNotEmpty
            ? "${Configs.baseUrl}${product.images[0]}"
            : null;

    return MyContainer(
      width: defaultWidth,
      radius: radius,
      backgroundColor: backgroundColor,
      hasGradient: hasGradient,
      customGradient: customGradient,
      hasShadow: false,
      hasBounce: true,
      bounceDuration: const Duration(milliseconds: 100),
      hasOpacityAnimation: true,
      opacityDuration: const Duration(milliseconds: 500),
      marginRight: 12,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Square image area
          AspectRatio(
            aspectRatio: 1, // Makes it square (width == height)
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
              child: CommonImageView(
                url: imageUrl,
                fit:
                    BoxFit
                        .cover, // Or BoxFit.contain if you want full image shown
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          // Text content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  displayCategory,
                  color: iconColor,
                  size: 12,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                MyText(
                  displayTitle,
                  weight: FontWeight.bold,
                  color: whiteColor,
                  size: 14,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),

                // Extra lines (optional)
                if (extraLine1 != null) ...[
                  MyText(
                    extraLine1!,
                    color: iconColor,
                    size: 12,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                ] else if (product?.description != null) ...[
                  MyText(
                    product.description,
                    color: iconColor,
                    size: 12,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                ],
                if (extraLine2 != null) ...[
                  MyText(
                    extraLine2!,
                    color: iconColor,
                    size: 12,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                ],
                if (extraLine3 != null) ...[
                  MyText(
                    extraLine3!,
                    color: iconColor,
                    size: 12,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                ],

                // Price & arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: MyText(
                        displayPrice,
                        color: iconColor,
                        size: 12,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_outward, color: iconColor, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
