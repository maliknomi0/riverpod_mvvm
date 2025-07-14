import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonImageView extends StatefulWidget {
  final String? url;
  final String? imagePath;
  final String? svgPath;
  final File? file;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit fit;
  final String placeHolder;
  final Color? color;
  final String? liteplaceholder;
  final String? darkplaceholder;
  const CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.fit = BoxFit.cover,
    this.placeHolder = 'assets/images/one_logo.png',
    this.color,
    this.liteplaceholder,
    this.darkplaceholder,
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
    if (widget.svgPath?.isNotEmpty == true) {
      return _buildRoundedContainer(
        SvgPicture.asset(
          widget.svgPath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          color: widget.color,
        ),
      );
    } else if (widget.file?.path.isNotEmpty == true) {
      return _buildRoundedContainer(
        Image.file(
          widget.file!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          color: widget.color,
        ),
      );
    } else if (widget.url?.isNotEmpty == true) {
      return _buildRoundedContainer(
        CachedNetworkImage(
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          imageUrl: widget.url!,
          color: widget.color,
          placeholder: (context, url) => const SizedBox(
            height: 23,
            width: 23,
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            final placeholderAsset = isDark
                ? (widget.darkplaceholder ?? widget.placeHolder)
                : (widget.liteplaceholder ?? widget.placeHolder);
            return Image.asset(
              placeholderAsset,
              height: widget.height,
              width: widget.width,
              fit: widget.fit,
              color: widget.color,
            );
          },
        ),
      );
    } else if (widget.imagePath?.isNotEmpty == true) {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 0),
      child: child,
    );
  }
}
