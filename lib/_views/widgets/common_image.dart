import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zene/_views/widgets/common_shimmer_widgets.dart';

class CommonImageView extends StatefulWidget {
  final String? url;
  final String? imagePath;
  final String? svgPath;
  final File? file;
  final double? height;
  final double? width;
  final double? radius;
  final double? circleRadius;
  final BoxFit fit;
  final String placeHolder;
  final Color? color;
  final IconData? icon;

  const CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.circleRadius,
    this.fit = BoxFit.cover,
    this.placeHolder = 'assets/images/zene_logo.png',
    this.color,
    this.icon,
  });

  @override
  _CommonImageViewState createState() => _CommonImageViewState();
}

class _CommonImageViewState extends State<CommonImageView> {
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
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity,
      child: _buildImageView(),
    );
  }

  Widget _buildImageView() {
    if (widget.svgPath != null && widget.svgPath!.isNotEmpty) {
      return _buildRoundedContainer(
        SvgPicture.asset(
          widget.svgPath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          color: widget.color,
        ),
      );
    } else if (widget.file != null && widget.file!.path.isNotEmpty) {
      return _buildRoundedContainer(
        Image.file(
          widget.file!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          color: widget.color,
        ),
      );
    } else if (widget.url != null && widget.url!.isNotEmpty) {
      return _buildRoundedContainer(
        CachedNetworkImage(
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          imageUrl: widget.url!,
          color: widget.color,
          placeholder: (context, url) => _buildShimmerPlaceholder(),
          errorWidget: (context, url, error) => Image.asset(
            widget.placeHolder,
            height: widget.height,
            width: widget.width,
            fit: widget.fit,
          ),
        ),
      );
    } else if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      return _buildRoundedContainer(
        Image.asset(
          widget.imagePath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          color: widget.color,
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildRoundedContainer(Widget child) {
    double effectiveRadius = widget.circleRadius ?? widget.radius!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: child,
    );
  }

  Widget _buildShimmerPlaceholder() {
    if (widget.circleRadius != null) {
      return CommonShimmerWidgets.shimmerCircle(
        size: widget.width ?? 44,
      );
    } else {
      return CommonShimmerWidgets.shimmerBox(
        width: widget.width ?? 44,
        height: widget.height ?? 44,
        radius: widget.radius ?? 8,
      );
    }
  }
}
