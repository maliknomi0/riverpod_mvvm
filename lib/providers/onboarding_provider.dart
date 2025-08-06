import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/view_models/onboarding/onboarding_vm.dart';

final onboardingVMProvider = ChangeNotifierProvider<OnboardingVM>((ref) => OnboardingVM());
