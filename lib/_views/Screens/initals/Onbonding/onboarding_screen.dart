import 'package:flutter/material.dart';
import 'package:riverpordmvvm/_services/StorageService.dart';
import 'package:riverpordmvvm/_views/widgets/MyContainer.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int contentState = 0;

  final List<String> titles = [
    'Track your progress',
    'Smart nutrition planning',
    'Personal coaching made simple',
  ];

  final List<String> descriptions = [
    'Stay on top of your fitness journey.\nLog meals, water, and workouts, all in one place.\nGet real-time updates and track every goal.',
    'Access personalized meal ideas every day.\nGet full macros, portions, and recipe details.\nFuel your body the right way.',
    'Train one-on-one with expert coaches.\nWhether online or face-to-face,\nyour transformation starts with us.',
  ];

  final List<String> images = [
    'assets/images/ob1.png',
    'assets/images/ob2.png',
    'assets/images/ob3.png', // Add a third image for the last screen
  ];

  @override
  void initState() {
    super.initState();
  }

  String getTitle(int index) => titles[index];
  String getDescription(int index) => descriptions[index];
  String getImage(int index) => images[index];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              child: Image(
                height: 640.0,
                image: AssetImage(getImage(contentState)),
              ),
            ),

            // Top Navigation
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  contentState != 0
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              contentState--;
                            });
                          },
                          child: const Icon(Icons.arrow_back_ios, size: 18.0),
                        )
                      : const SizedBox(),
                  contentState != 2
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              contentState = 2;
                            });
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),

            // Bottom Content
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: MyContainer(
                  paddingBottom: 32.0,
                  paddingTop: 32.0,
                  paddingLeft: 32.0,
                  paddingRight: 32.0,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getTitle(contentState),
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        getDescription(contentState),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      // Indicators and Next Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(3, (index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 4.0),
                                height: 4.0,
                                width: contentState == index ? 18.0 : 12.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: contentState == index
                                      ? lightPrimaryColor
                                      : const Color(0xFFCBD6F3),
                                ),
                              );
                            }),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (contentState < 2) {
                                  contentState++;
                                } else {
                                  StorageService().setOnboardingComplete();
                                  Navigator.pop(context); // End onboarding
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
