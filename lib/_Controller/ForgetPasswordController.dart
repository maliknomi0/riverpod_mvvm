import 'package:flutter/material.dart';

import 'package:riverpordmvvm/Utils/Mysnackbar.dart';
import 'package:riverpordmvvm/Utils/app_exceptions.dart';
import 'package:riverpordmvvm/Utils/loading.dart';
import 'package:riverpordmvvm/_services/app_services.dart';
import 'package:riverpordmvvm/_views/Screens/initals/forgetpassword/otp_screen.dart';
import 'package:riverpordmvvm/_views/Screens/initals/forgetpassword/set_password.dart';
import 'package:riverpordmvvm/_views/Screens/initals/login/login.dart';
import 'package:riverpordmvvm/widgets/my_custom_navigator.dart';

class PasswordResetController extends ChangeNotifier {
  final AppService _appService = AppService();

  // Step 1: Send OTP
  Future<void> sendOtp(String email, BuildContext context) async {
    showLoader(context, "Sending OTP...");

    try {
      final response = await _appService.getotp({"email": email.toString()});
      debugPrint("Response from getotp: $response"); // Debug log

      if (response['success'] == true) {
        Navigator.pop(context); // Hide loader
        Mysnackbar.showSuccess(context, "OTP sent successfully");
        MyCustomNavigator.push(context, OTPVerificationScreen(email: email));
      } else {
        Navigator.pop(context);
        Mysnackbar.showError(
          context,
          response['message'],
        );
      }
      // ignore: unused_catch_clause
    } on AppException catch (e) {
      Navigator.pop(context);
      Mysnackbar.showError(context, e.message);
    } catch (e) {
      Navigator.pop(context);
      // Mysnackbar.showError(context, "Something went wrong: $e");
    }
  }

  // Step 2: Verify OTP
  Future<void> verifyOtp(String email, String otp, BuildContext context) async {
    if (otp.length != 6) {
      Mysnackbar.showWarning(context, "Please enter a 4-digit OTP");
      return;
    }

    showLoader(context, "Verifying OTP...");

    try {
      final response = await _appService.verifyOtp({
        "email": email,
        "otp": otp,
      });

      if (response['success'] == true) {
        Navigator.pop(context);
        Mysnackbar.showSuccess(context, "OTP verified successfully");
        MyCustomNavigator.push(context, SetPassword(email: email, otp: otp));
      } else {
        Navigator.pop(context);
        Mysnackbar.showError(context, response['message'] ?? "Invalid OTP");
      }
      // ignore: unused_catch_clause
    } on AppException catch (e) {
      Navigator.pop(context);
      // Mysnackbar.showError(context, e.message);
    } catch (e) {
      Navigator.pop(context);
      // Mysnackbar.showError(context, "Something went wrong: $e");
    }
  }

  // Step 3: Set New Password
  Future<void> setNewPassword(
    String email,
    String otp,
    String newPassword,
    BuildContext context,
  ) async {
    // if (newPassword.length < 6) {
    //   Mysnackbar.showError(context, "Password must be at least 6 characters");
    //   return;
    // }

    showLoader(context, "Changing password...");

    try {
      final response = await _appService.newPassword({
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      });

      if (response['success'] == true) {
        Navigator.pop(context); // Hide loader
        Mysnackbar.showSuccess(context, "Password changed successfully");
        MyCustomNavigator.removeUntil(context, const Login());
      } else {
        Navigator.pop(context);
        // Mysnackbar.showError(
        //   context,
        //   response['message'] ?? "Failed to change password",
        // );
      }
      // ignore: unused_catch_clause
    } on AppException catch (e) {
      Navigator.pop(context);
      // Mysnackbar.showError(context, e.message);
    } catch (e) {
      Navigator.pop(context);
      // Mysnackbar.showError(context, "Something went wrong: $e");
    }
  }
}
