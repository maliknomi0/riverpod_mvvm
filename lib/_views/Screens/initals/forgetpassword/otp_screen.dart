import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/Utils/screen.dart';
import 'package:riverpordmvvm/_Controller/ForgetPasswordController.dart';
import 'package:riverpordmvvm/_views/widgets/MyButton.dart';
import 'package:riverpordmvvm/_views/widgets/MyText.dart';
import 'package:riverpordmvvm/_views/widgets/my_otp_text_field.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class OTPVerificationScreen extends ConsumerStatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends ConsumerState<OTPVerificationScreen> {
  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;
  bool canResend = false;
  int remainingTime = 30;

  @override
  void initState() {
    super.initState();
    otpControllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
    startTimer();
  }

  void startTimer() async {
    for (int i = remainingTime; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        remainingTime = i - 1;
        canResend = remainingTime == 0;
      });
    }
  }

  void resendOTP() {
    final controller = ref.read(passwordResetControllerProvider);
    controller.sendOtp(widget.email, context);
    if (mounted) {
      setState(() {
        remainingTime = 30;
        canResend = false;
      });
    }
    startTimer();
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initScreenDimensions(context); // Initialize screenWidth & screenHeight

    final otpBoxWidth = (screenWidth - (18 * 2) - (8 * 10)) / 6;
    final otpFieldWidth = otpBoxWidth < 45 ? 45 : otpBoxWidth;

    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'enter_otp'.tr(),
                        style: AppAuthHeading,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      MyText(
                        "otp_sent_to".tr(namedArgs: {'email': widget.email}),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: SizedBox(
                                width: otpFieldWidth.toDouble(),
                                height: 60,
                                child: MyotpTextField(
                                  focusNode: focusNodes[index],
                                  maxLength: 1,
                                  controller: otpControllers[index],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && index < 5) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(focusNodes[index + 1]);
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(focusNodes[index - 1]);
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 30),
                      MyButton(
                        hasGradient: true,
                      onTap: () {
                          final controller =
                              ref.read(passwordResetControllerProvider);
                          String otp = otpControllers.map((e) => e.text).join();
                          controller.verifyOtp(widget.email, otp, context);
                        },
                        buttonText: 'verify_otp',
                      ),
                      const SizedBox(height: 16),
                      MyText(
                        canResend
                            ? 'can_resend_otp'.tr()
                            : 'resend_otp_in'.tr(
                                namedArgs: {'seconds': '$remainingTime'},
                              ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: canResend ? resendOTP : null,
                        child: MyText(
                          'resend_otp',
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
