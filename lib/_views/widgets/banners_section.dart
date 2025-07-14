import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zene/_Models/banner_model.dart';
import 'package:zene/_views/widgets/common_image.dart';
import 'package:zene/_views/widgets/common_shimmer_widgets.dart';
import 'package:zene/config.dart';

class BannersSection extends StatefulWidget {
  final List<BannerModel> mainBanners;
  final List<BannerModel> smallBanners;
  final bool isLoading;

  const BannersSection({
    super.key,
    required this.mainBanners,
    required this.smallBanners,
    this.isLoading = false,
  });

  @override
  State<BannersSection> createState() => _BannersSectionState();
}

class _BannersSectionState extends State<BannersSection> {
  late PageController _mainBannerController;
  late PageController _smallBannerController;

  Timer? _mainTimer;
  Timer? _smallTimer;

  int _mainPage = 0;
  int _smallPage = 0;

  @override
  void initState() {
    super.initState();
    _mainBannerController = PageController(viewportFraction: 0.95);
    _smallBannerController = PageController(viewportFraction: 0.95);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.mainBanners.isNotEmpty) _startMainBannerScroll();
      if (widget.smallBanners.isNotEmpty) _startSmallBannerScroll();
    });
  }

  @override
  void didUpdateWidget(covariant BannersSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((oldWidget.mainBanners.isEmpty || oldWidget.mainBanners.length < 2) &&
        widget.mainBanners.isNotEmpty &&
        _mainTimer == null) {
      _startMainBannerScroll();
    }

    if ((oldWidget.smallBanners.isEmpty || oldWidget.smallBanners.length < 2) &&
        widget.smallBanners.isNotEmpty &&
        _smallTimer == null) {
      _startSmallBannerScroll();
    }
  }

  void _startMainBannerScroll() {
    if (_mainTimer != null) return;

    _mainTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || widget.mainBanners.length < 2) return;

      _mainPage = (_mainPage + 1) % widget.mainBanners.length;
      _mainBannerController.animateToPage(
        _mainPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  void _startSmallBannerScroll() {
    if (_smallTimer != null) return;

    _smallTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted || widget.smallBanners.length < 2) return;

      _smallPage = (_smallPage + 1) % widget.smallBanners.length;
      _smallBannerController.animateToPage(
        _smallPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _mainTimer?.cancel();
    _smallTimer?.cancel();
    _mainBannerController.dispose();
    _smallBannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 Show shimmer only if loading & both banners are empty
    final bool showShimmer =
        widget.isLoading &&
        widget.mainBanners.isEmpty &&
        widget.smallBanners.isEmpty;

    if (showShimmer) {
      return Column(
        children: [
          CommonShimmerWidgets.shimmerBox(width: 325, height: 144, radius: 12),
          const SizedBox(height: 12),
          SizedBox(
            height: 74,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder:
                  (context, _) => CommonShimmerWidgets.shimmerBox(
                    width: 325,
                    height: 74,
                    radius: 8,
                  ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        /// MAIN BANNER
        if (widget.mainBanners.isNotEmpty)
          Column(
            children: [
              SizedBox(
                height: 144,
                child: PageView.builder(
                  controller: _mainBannerController,
                  itemCount: widget.mainBanners.length,
                  onPageChanged: (i) => setState(() => _mainPage = i),
                  itemBuilder: (context, index) {
                    final banner = widget.mainBanners[index];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CommonImageView(
                          url: '${Configs.imageUrl}${banner.image}',
                          width: 325,
                          height: 144,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.mainBanners.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _mainPage == index ? 12 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color:
                          _mainPage == index ? Colors.black87 : Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
            ],
          ),

        /// SMALL BANNERS
        if (widget.smallBanners.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              height: 74,
              child: PageView.builder(
                controller: _smallBannerController,
                itemCount: widget.smallBanners.length,
                onPageChanged: (i) => setState(() => _smallPage = i),
                itemBuilder: (context, index) {
                  final banner = widget.smallBanners[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CommonImageView(
                        url: '${Configs.imageUrl}${banner.image}',
                        width: 325,
                        height: 74,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
