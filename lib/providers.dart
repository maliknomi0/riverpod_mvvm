import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '_Controller/ForgetPasswordController.dart';
import '_Controller/Login_controller.dart';
import '_Controller/signup_controller.dart';
import '_Controller/theme_Controller.dart';
import '_Controller/language_controller.dart';
import '_services/StorageService.dart';

final themeControllerProvider =
    ChangeNotifierProvider<ThemeController>((ref) => ThemeController());
final signupControllerProvider =
    ChangeNotifierProvider<SignupController>((ref) => SignupController());
final loginControllerProvider =
    ChangeNotifierProvider<LoginController>((ref) => LoginController());
final passwordResetControllerProvider = ChangeNotifierProvider<
    PasswordResetController>((ref) => PasswordResetController());
final storageServiceProvider = Provider<StorageService>((ref) => StorageService());
final localeProvider = ChangeNotifierProvider<LocaleProvider>(
    (ref) => LocaleProvider(initialLocale: const Locale('en')));
