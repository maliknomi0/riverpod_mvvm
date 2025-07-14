import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:riverpordmvvm/Configs/Assets.dart';
import 'package:riverpordmvvm/Utils/Mysnackbar.dart';
import 'package:riverpordmvvm/Utils/screen.dart';
import 'package:riverpordmvvm/_views/widgets/MyButton.dart';
import 'package:riverpordmvvm/_views/widgets/MyText.dart';
import 'package:riverpordmvvm/_views/widgets/common_image.dart';
import 'package:riverpordmvvm/_views/widgets/my_text_field.dart';
import 'package:riverpordmvvm/providers.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class ForgetPassword extends ConsumerStatefulWidget {
  const ForgetPassword({super.key});

  @override
  ConsumerState<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ConsumerState<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initScreenDimensions(context); // ✅ Load dimensions
    ref.watch(localeProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: kToolbarHeight + 20,
                      left: 18,
                      right: 18,
                      bottom: 10,
                    ),
                    child: CommonImageView(imagePath: AppIamges.imagesgold),
                  ),
                  const Spacer(), // Pushes form to bottom
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("password_recovery", style: AppAuthHeading),
                        const SizedBox(height: 6),
                        MyText("recover_instruction", size: 14),
                        const SizedBox(height: 18),
                        MyTextField(
                          controller: emailController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              top: 16,
                              bottom: 16,
                              right: 5,
                            ),
                            child: Icon(Bootstrap.envelope, size: 18),
                            //  Image.asset(
                            //   AppIamges.iconsEmail,
                            //   color: iconColor,
                            //   height: 18,
                            // ),
                          ),
                          hint: "email_address",
                        ),
                        const SizedBox(height: 12),
                        MyText("use_another_method"),
                        const SizedBox(height: 28),
                        MyButton(
                          hasGradient: true,
                          onTap: () {
                            final email = emailController.text.trim();
                            final controller = ref.read(
                              passwordResetControllerProvider,
                            );

                            if (email.isEmpty) {
                              Mysnackbar.showWarning(
                                context,
                                "Please enter your email",
                              );
                              return;
                            }

                            if (!EmailValidator.validate(email)) {
                              Mysnackbar.showError(
                                context,
                                "Invalid email format",
                              );
                              return;
                            }

                            controller.sendOtp(email, context);
                          },
                          buttonText: "next",
                        ),
                        const SizedBox(height: 38),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
