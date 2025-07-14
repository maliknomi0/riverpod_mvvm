import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmerWidgets {
  /// Rectangle shimmer box
  static Widget shimmerBox({
    double width = 100,
    double height = 20,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  /// Circular shimmer (use for icons, avatars etc.)
  static Widget shimmerCircle({double size = 60}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
