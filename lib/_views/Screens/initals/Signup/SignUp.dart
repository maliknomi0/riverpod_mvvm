import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:riverpordmvvm/Configs/Assets.dart';
import 'package:riverpordmvvm/Utils/Mysnackbar.dart';
import 'package:riverpordmvvm/Utils/screen.dart';
import 'package:riverpordmvvm/_views/Screens/initals/login/login.dart';
import 'package:riverpordmvvm/_views/widgets/CustomCheckBox.dart';
import 'package:riverpordmvvm/_views/widgets/MyButton.dart';
import 'package:riverpordmvvm/_views/widgets/MyText.dart';
import 'package:riverpordmvvm/_views/widgets/common_image.dart';
import 'package:riverpordmvvm/_views/widgets/my_custom_navigator.dart';
import 'package:riverpordmvvm/_views/widgets/my_text_field.dart';
import 'package:riverpordmvvm/providers.dart';
import 'package:riverpordmvvm/themes/theme_constants.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool isActive = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  Country? _country;

  @override
  void initState() {
    _country = Country(
      phoneCode: "971",
      countryCode: "AE",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "United Arab Emirates",
      displayName: "United Arab Emirates",
      e164Key: "",
      example: '',
      displayNameNoCountryCode: '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initScreenDimensions(context);
    ref.watch(localeProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ✅ Image Header
              SizedBox(
                height: screenHeight * 0.35,
                width: double.infinity,
                child: CommonImageView(imagePath: AppIamges.imagesLogin),
              ),
              const SizedBox(height: 12),

              // ✅ Heading
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("create_account".tr(), style: AppAuthHeading),
                    const SizedBox(height: 15),

                    MyTextField(
                      controller: _nameController,
                      prefixIcon: _buildIcon(Bootstrap.person),
                      hint: "name",
                    ),
                    MyTextField(
                      controller: _emailController,
                      prefixIcon: _buildIcon(Bootstrap.envelope),
                      hint: "email_address",
                    ),
                    MyTextField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                      prefixIcon: _buildCountryPicker(context),
                      hint: "Phone",
                    ),
                    MyTextField(
                      controller: _passwordController,
                      isObSecure: !_isPasswordVisible,
                      prefixIcon: _buildIcon(BoxIcons.bx_lock),
                      suffixIcon: _toggleVisibility(() {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      }, _isPasswordVisible),
                      hint: "password",
                    ),
                    MyTextField(
                      controller: _confirmPasswordController,
                      isObSecure: !_isConfirmPasswordVisible,
                      prefixIcon: _buildIcon(BoxIcons.bx_lock),
                      suffixIcon: _toggleVisibility(() {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      }, _isConfirmPasswordVisible),
                      hint: "confirm_password",
                    ),

                    Row(
                      children: [
                        CustomCheckBox(
                          isActive: isActive,
                          onTap: () => setState(() => isActive = !isActive),
                          iscircle: true,
                        ),
                        const SizedBox(width: 6),
                        Expanded(child: MyText("i_agree_with", size: 12)),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // ✅ Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                          onTap: () {
                            MyCustomNavigator.removeUntil(
                              context,
                              const Login(),
                            );
                          },
                          buttonText: "login_in",
                          width: screenWidth / 2.3,
                          hasGradient: true,
                          height: 40,
                        ),
                        MyButton(
                          onTap: () {
                            final controller = ref.read(
                              signupControllerProvider,
                            );
                            final name = _nameController.text.trim();
                            final email = _emailController.text.trim();
                            final phone = _phoneNumberController.text.trim();
                            final password = _passwordController.text.trim();
                            final confirmPassword = _confirmPasswordController
                                .text
                                .trim();

                            if (name.isEmpty ||
                                email.isEmpty ||
                                phone.isEmpty ||
                                password.isEmpty ||
                                confirmPassword.isEmpty) {
                              Mysnackbar.showWarning(
                                context,
                                "Please fill all fields",
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
                              Mysnackbar.showError(
                                context,
                                "Passwords do not match",
                              );
                              return;
                            }

                            if (!isActive) {
                              Mysnackbar.showWarning(
                                context,
                                "Please agree to terms and conditions",
                              );
                              return;
                            }

                            final Map<String, dynamic> body = {
                              "name": name,
                              "email": email,
                              "password": password,
                              "phoneNo": phone,
                              "country": _country?.name ?? '',
                              "countryCode": "+${_country?.phoneCode ?? ''}",
                              "role": "user",
                            };

                            controller.signup(body, context);
                          },
                          buttonText: "sign_up",
                          width: screenWidth / 2.3,
                          height: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Icon(iconData, size: 18),
    );
  }

  Widget _toggleVisibility(VoidCallback onTap, bool isVisible) {
    return IconButton(
      icon: Icon(
        isVisible ? FontAwesome.eye_slash_solid : FontAwesome.eye_solid,
        size: 18,
      ),
      onPressed: onTap,
    );
  }

  Widget _buildCountryPicker(BuildContext context) {
    return InkWell(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          showSearch: true,
          countryListTheme: CountryListThemeData(
            flagSize: 25,
            borderRadius: BorderRadius.circular(20),
            bottomSheetHeight: 500,
          ),
          onSelect: (Country country) {
            setState(() {
              _country = country;
            });
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(_country?.flagEmoji ?? ""),
            const SizedBox(width: 4),
            MyText("+${_country?.phoneCode ?? ''}", size: 14),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
