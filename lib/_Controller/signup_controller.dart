import 'package:flutter/material.dart';
import 'package:riverpordmvvm/Utils/Mysnackbar.dart';
import 'package:riverpordmvvm/Utils/app_exceptions.dart';
import 'package:riverpordmvvm/Utils/loading.dart';
import 'package:riverpordmvvm/_Models/user_model.dart';

import 'package:riverpordmvvm/_services/app_services.dart';
import 'package:riverpordmvvm/_services/StorageService.dart';
import 'package:riverpordmvvm/_views/Screens/initals/login/login.dart';

class SignupController extends ChangeNotifier {
  final AppService _appService = AppService();

  Future<void> signup(Map<String, dynamic> data, BuildContext context) async {
    showLoader(context, "signing_you_up");

    try {
      final response = await _appService.signup(data);

      if (response['success'] != true) {
        throw AppException(response['message'] ?? "signup_failed");
      }

      // Step 1: Check token and user data
      final token = response['token'] as String?;
      final userData = response['user'] as Map<String, dynamic>?;

      if (token == null || userData == null) {
        throw AppException("invalid_response_format");
      }

      // Step 2: Try parsing
      late UserModel user;
      try {
        user = UserModel.fromJson(userData);
      } catch (e) {
        throw AppException("User parsing failed: $e");
      }

      // Step 3: Save
      final storage = StorageService();
      await storage.setToken(token);
      await storage.setLogin(user);

      // Step 4: Close loader and navigate
      Navigator.pop(context);
      Mysnackbar.showSuccess(
          context, response['message'] ?? "signup_successful");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } on AppException catch (e) {
      Navigator.pop(context);
      Mysnackbar.showError(context, e.message);
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("Transaction cannot be rolled back")) {
        debugPrint("⚠️ Ignored rollback error: $e");
      } else {
        Mysnackbar.showError(context, "Something went wrong: $e");
      }
    }
  }
}
