import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:riverpordmvvm/Configs/Assets.dart';
import 'package:riverpordmvvm/widgets/MyButton.dart';
import 'package:riverpordmvvm/widgets/MyText.dart';
import 'package:riverpordmvvm/widgets/common_image.dart';
import 'package:riverpordmvvm/widgets/my_text_field.dart';
import 'package:riverpordmvvm/providers.dart';
import 'package:riverpordmvvm/core/themes/theme_constants.dart';

import '../../../../Utils/Mysnackbar.dart';

class SetPassword extends ConsumerStatefulWidget {
  final String email;
  final String otp;

  const SetPassword({super.key, required this.email, required this.otp});

  @override
  ConsumerState<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends ConsumerState<SetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CommonImageView(imagePath: AppIamges.imagesgold),
              ),
            ],
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Set New Password", style: AppAuthHeading),
                  MyText(
                    "Set a new password that must be different from the old password",
                    size: 14,
                  ),
                  const SizedBox(height: 18),

                  // ✅ New Password
                  MyTextField(
                    controller: passwordController,
                    isObSecure: !_isPasswordVisible,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(BoxIcons.bx_lock, size: 18),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? FontAwesome.eye_slash_solid
                            : FontAwesome.eye_solid,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        );
                      },
                    ),
                    hint: "Password",
                  ),

                  // ✅ Confirm Password
                  MyTextField(
                    controller: confirmPasswordController,
                    isObSecure: !_isConfirmPasswordVisible,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(BoxIcons.bx_lock, size: 18),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? FontAwesome.eye_slash_solid
                            : FontAwesome.eye_solid,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(
                          () => _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible,
                        );
                      },
                    ),
                    hint: "Confirm Password",
                  ),
                  const SizedBox(height: 18),

                  // ✅ Submit Button
                  MyButton(
                    hasGradient: true,
                    onTap: () {
                      final controller = ref.read(
                        passwordResetControllerProvider,
                      );
                      final password = passwordController.text.trim();
                      final confirmPassword = confirmPasswordController.text
                          .trim();

                      if (password.isEmpty || confirmPassword.isEmpty) {
                        Mysnackbar.showWarning(
                          context,
                          "Please enter all fields",
                        );
                        return;
                      }

                      if (password.length < 8 ||
                          !RegExp(r'[A-Z]').hasMatch(password) ||
                          !RegExp(r'\d').hasMatch(password)) {
                        Mysnackbar.showError(
                          context,
                          "Password must be at least 8 characters, include 1 uppercase and 1 number",
                        );
                        return;
                      }

                      if (password != confirmPassword) {
                        Mysnackbar.showError(context, "Passwords do not match");
                        return;
                      }

                      controller.setNewPassword(
                        widget.email,
                        widget.otp,
                        password,
                        context,
                      );
                    },
                    buttonText: "Change Password",
                  ),
                  const SizedBox(height: 38),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
