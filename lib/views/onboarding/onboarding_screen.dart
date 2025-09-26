import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes/theme_constants.dart';
import '../../../providers/onboarding_provider.dart';
import '../../../widgets/common_image.dart';
import '../../../widgets/my_container.dart';
import '../../../widgets/my_text.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(onboardingVMProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main Image
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              child: CommonImageView(
                imagePath: vm.currentStep.imageAsset,
                height: 640.0,
                fit: BoxFit.cover,
              ),
            ),
            // Top Navigation
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  vm.contentState != 0
                      ? GestureDetector(
                          onTap: () => ref.read(onboardingVMProvider).previousPage(),
                          child: const Icon(Icons.arrow_back_ios, size: 18.0),
                        )
                      : const SizedBox(),
                  vm.contentState != vm.steps.length - 1
                      ? GestureDetector(
                          onTap: () => ref.read(onboardingVMProvider).skipToEnd(),
                          child: const MyText('Skip'),
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
                      MyText.heading(
                        vm.currentStep.title,
                        textAlign: TextAlign.center,
                        translate: false,
                      ),
                      const SizedBox(height: 16.0),
                      MyText(
                        vm.currentStep.description,
                        textAlign: TextAlign.center,
                        size: fontSizeS,
                        translate: false,
                      ),
                      const SizedBox(height: 40.0),
                      // Indicators & Next Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: List.generate(vm.steps.length, (index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 4.0),
                                height: 4.0,
                                width: vm.contentState == index ? 18.0 : 12.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: vm.contentState == index
                                      ? lightPrimaryColor
                                      : const Color(0xFFCBD6F3),
                                ),
                              );
                            }),
                          ),
                          GestureDetector(
                            onTap: () => ref.read(onboardingVMProvider).nextPage(() {
                              Navigator.pop(context); // Onboarding complete
                            }),
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
