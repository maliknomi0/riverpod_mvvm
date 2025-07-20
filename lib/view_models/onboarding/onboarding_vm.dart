import 'package:flutter/material.dart';
import 'package:riverpordmvvm/core/storage/hive_storage_helper.dart';
import '../../../models/onboarding_step_model.dart';

class OnboardingVM extends ChangeNotifier {
  int contentState = 0;

  final List<OnboardingStep> steps = [
    OnboardingStep(
      title: 'Track your progress',
      description: 'Stay on top of your fitness journey.\nLog meals, water, and workouts, all in one place.\nGet real-time updates and track every goal.',
      imageAsset: 'assets/images/ob1.png',
    ),
    OnboardingStep(
      title: 'Smart nutrition planning',
      description: 'Access personalized meal ideas every day.\nGet full macros, portions, and recipe details.\nFuel your body the right way.',
      imageAsset: 'assets/images/ob2.png',
    ),
    OnboardingStep(
      title: 'Personal coaching made simple',
      description: 'Train one-on-one with expert coaches.\nWhether online or face-to-face,\nyour transformation starts with us.',
      imageAsset: 'assets/images/ob3.png',
    ),
  ];

  OnboardingStep get currentStep => steps[contentState];

  void nextPage(VoidCallback onComplete) {
    if (contentState < steps.length - 1) {
      contentState++;
      notifyListeners();
    } else {
      HiveStorageHelper.setOnboardingComplete();
      onComplete();
    }
  }

  void previousPage() {
    if (contentState > 0) {
      contentState--;
      notifyListeners();
    }
  }

  void skipToEnd() {
    contentState = steps.length - 1;
    notifyListeners();
  }
}
