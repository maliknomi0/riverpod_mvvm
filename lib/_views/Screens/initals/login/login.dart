import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:riverpordmvvm/Configs/Assets.dart';
import 'package:riverpordmvvm/Utils/Mysnackbar.dart';
import 'package:riverpordmvvm/Utils/screen.dart';
import 'package:riverpordmvvm/_views/Screens/initals/Signup/SignUp.dart';
import 'package:riverpordmvvm/_views/Screens/initals/forgetpassword/forget_password.dart';
import 'package:riverpordmvvm/widgets/LanguageCustomAppBar.dart';
import 'package:riverpordmvvm/widgets/MyButton.dart';
import 'package:riverpordmvvm/widgets/MyText.dart';
import 'package:riverpordmvvm/widgets/common_image.dart';
import 'package:riverpordmvvm/widgets/my_custom_navigator.dart';
import 'package:riverpordmvvm/widgets/my_text_field.dart';
import 'package:riverpordmvvm/providers.dart';
import 'package:riverpordmvvm/core/themes/theme_constants.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    initScreenDimensions(context);
    ref.watch(localeProvider);

    return Scaffold(
      appBar: LanguageBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Controlled height image
              SizedBox(
                height: screenHeight * 0.28,
                width: double.infinity,
                child: CommonImageView(imagePath: AppIamges.imagesLogin),
              ),
              const SizedBox(height: 12),

              // ✅ Heading
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("welcome_back".tr(), style: AppAuthHeading),
              ),

              const SizedBox(height: 10),

              // ✅ Email Field
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    MyTextField(
                      controller: _emailController,
                      prefixIcon: Icon(Bootstrap.envelope, size: 18),

                      // Image.asset(
                      //   AppIamges.iconsEmail,
                      //   color: iconColor,
                      //   height: 18,
                      // ),
                      hint: "email_address",
                    ),

                    // ✅ Password Field
                    MyTextField(
                      controller: _passwordController,
                      isObSecure: !_isPasswordVisible,
                      prefixIcon: Icon(BoxIcons.bx_lock, size: 18),

                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? FontAwesome.eye_slash_solid
                              : FontAwesome.eye_solid,
                          size: 18,
                        ),
                        onPressed: () {
                          if (mounted) {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          }
                        },
                      ),
                      hint: "password",
                    ),

                    // ✅ Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: MyText(
                        "forgot_password",
                        onTap: () {
                          MyCustomNavigator.push(
                            context,
                            const ForgetPassword(),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ✅ Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                          hasGradient: true,
                          onTap: () {
                            MyCustomNavigator.removeUntil(
                              context,
                              const SignUp(),
                            );
                          },
                          buttonText: "sign_up",
                          width: screenWidth / 2.3,
                          height: 40,
                        ),
                        MyButton(
                          onTap: () {
                            final controller = ref.read(
                              loginControllerProvider,
                            );
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              Mysnackbar.showWarning(
                                context,
                                "Please enter email and password",
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
                            if (password.length < 6) {
                              Mysnackbar.showError(
                                context,
                                "Password must be at least 6 characters",
                              );
                              return;
                            }

                            controller.login({
                              "email": email,
                              "password": password,
                            }, context);
                          },
                          buttonText: "login",
                          width: screenWidth / 2.3,
                          height: 40,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ✅ Divider with "or"
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(color: DividerColor, thickness: 0.8),
                        ),
                        const SizedBox(width: 10),
                        MyText("or_sign_in_with", size: 12),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Divider(color: DividerColor, thickness: 0.8),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ✅ Apple & Google buttons
                    MyButton(
                      onTap: () {},
                      buttonText: "sign_up_apple",
                      choiceIcon: AppIamges.AppleSignUpButton,

                      hasIcon: true,
                      hasGradient: true,
                    ),
                    const SizedBox(height: 8),
                    MyButton(
                      onTap: () async {
                        if (mounted) {
                          try {
                            setState(() {});
                          } catch (e) {
                            if (mounted) setState(() {});
                            rethrow;
                          }
                        }
                      },
                      buttonText: "sign_up_google",
                      choiceIcon: AppIamges.GoogleSignUpButton,
                      hasIcon: true,
                      hasGradient: true,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
