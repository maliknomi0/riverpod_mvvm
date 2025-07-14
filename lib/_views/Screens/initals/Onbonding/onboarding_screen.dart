import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zene/_Controller/language_controller.dart';
import 'package:zene/Configs/Assets.dart';
import 'package:zene/_Models/onbondingModel.dart';
import 'package:zene/services/storage.dart';
import 'package:zene/themes/theme_constants.dart';
import 'package:zene/_views/Screens/initals/login/login.dart';
import 'package:zene/_views/widgets/LanguageCustomAppBar.dart';
import 'package:zene/_views/widgets/MyButton.dart';
import 'package:zene/_views/widgets/MyText.dart';
import 'package:zene/_views/widgets/common_image.dart';
import 'package:zene/_views/widgets/my_custom_navigator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller = PageController();
  final Storage _storage = Storage(); // Add Storage instance
  int pageIndex = 0;
  List<PageModel> pageList = [
    PageModel(
      image: AppIamges.onboarding1,
      title: 'onbondingtitle1',
      body: 'onbondingbody1',
    ),
    PageModel(
      image: AppIamges.onboarding2,
      title: 'onbondingtitle2',
      body: 'onbondingbody2',
    ),
    PageModel(
      image: AppIamges.onboarding3,
      title: 'onbondingtitle3',
      body: 'onbondingbody3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    context.watch<LocaleProvider>();

    return Scaffold(
      appBar: LanguageBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: controller,
              physics: const ScrollPhysics(),
              onPageChanged: (val) {
                if (mounted) {
                  setState(() {
                    pageIndex = val;
                  });
                }
              },
              itemCount: pageList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, i) {
                return PageSlider(
                  image: pageList[i].image,
                  title: pageList[i].title,
                  body: pageList[i].body,
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: MyButton(
                    radius: 10,
                    width: MediaQuery.sizeOf(context).width,
                    onTap: () async {
                      if (pageIndex == 0) {
                        controller.jumpToPage(1);
                      } else if (pageIndex == 1) {
                        controller.jumpToPage(2);
                      } else {
                        await _storage.setOnboardingComplete();
                        MyCustomNavigator.removeUntil(context, Login());
                      }
                    },
                    buttonText:
                        pageIndex == 0
                            ? "next"
                            : pageIndex == 1
                            ? "next"
                            : "proceed_to_login",
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageSlider extends StatelessWidget {
  const PageSlider({
    super.key,
    required this.image,
    required this.title,
    required this.body,
  });

  final String image;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonImageView(
          height: MediaQuery.sizeOf(context).height / 2,
          width: MediaQuery.sizeOf(context).width,
          imagePath: image,
        ),
        SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title.tr(), style: AppOnBoardingText),
              const SizedBox(height: 6),
              MyText(body, size: 16, weight: FontWeight.w400),
            ],
          ),
        ),
      ],
    );
  }
}
