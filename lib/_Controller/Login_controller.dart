import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:riverpordmvvm/Utils/Mysnackbar.dart';
import 'package:riverpordmvvm/Utils/app_exceptions.dart';
import 'package:riverpordmvvm/Utils/loading.dart';
import 'package:riverpordmvvm/_Models/user_model.dart';
import 'package:riverpordmvvm/_services/StorageService.dart';
import 'package:riverpordmvvm/_services/app_services.dart';
import 'package:riverpordmvvm/_services/fcm_handler.dart';
import 'package:riverpordmvvm/_services/notification_services.dart';
import 'package:riverpordmvvm/_views/widgets/my_custom_navigator.dart';
import 'package:riverpordmvvm/global/globle.dart';

class LoginController extends ChangeNotifier {
  final AppService _appService = AppService();
  Future<void> googleSignup(
      Map<String, dynamic> data, BuildContext context) async {
    showLoader(context, "logging_in");

    try {
      final response = await _appService.signup(data);

      if (response['success'] == true) {
        final token = response['token'] as String?;
        final userData = response['user'] as Map<String, dynamic>?;

        if (token == null || userData == null) {
          throw AppException("invalid_response_format");
        }

        userSD = UserModel.fromJson(userData);

        final storage = StorageService();
        await storage.setToken(token);
        await storage.setLogin(userSD!);

        await FCMService().initializeAndSendToken();
        await FCMHandler.setupNotificationHandlers();

        if (context.mounted) {
          Navigator.pop(context);
          Mysnackbar.showSuccess(
            context,
            response['message'] ?? "login_successful",
          );

          await Future.delayed(const Duration(milliseconds: 100));
          try {
            // MyCustomNavigator.replace(context, const BottomBarNav());

          } catch (e) {
            // Navigation error silently ignored
          }
        }
      } else {
        final message = response['message']?.toString() ?? '';

        if (message.toLowerCase().contains('user already exists')) {
          Navigator.pop(context);
          await login(
              {'email': data['email'], 'password': data['password']}, context);
        } else {
          throw AppException(message.isNotEmpty ? message : "signup_failed");
        }
      }
    } on AppException catch (e) {
      if (e.message.toLowerCase().contains('user already exists')) {
        if (context.mounted) Navigator.pop(context);
        await login(
            {'email': data['email'], 'password': data['password']}, context);
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          Mysnackbar.showError(context, e.message);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        Mysnackbar.showError(
          context,
          "something_went_wrong".tr(args: [e.toString()]),
        );
      }
    }
  }

  Future<void> appleSignup(
      Map<String, dynamic> data, BuildContext context) async {
    showLoader(context, "logging_in");

    try {
      final response = await _appService.signup(data);

      if (response['success'] == true) {
        final token = response['token'] as String?;
        final userData = response['user'] as Map<String, dynamic>?;

        if (token == null || userData == null) {
          throw AppException("invalid_response_format");
        }

        userSD = UserModel.fromJson(userData);

        final storage = StorageService();
        await storage.setToken(token);
        await storage.setLogin(userSD!);

        await FCMService().initializeAndSendToken();
        await FCMHandler.setupNotificationHandlers();

        if (context.mounted) {
          Navigator.pop(context);
          Mysnackbar.showSuccess(
            context,
            response['message'] ?? "login_successful",
          );

          await Future.delayed(const Duration(milliseconds: 100));
          try {
            // MyCustomNavigator.replace(context, const BottomBarNav());
          } catch (e) {
            // Navigation error silently ignored
          }
        }
      } else {
        final message = response['message']?.toString() ?? '';

        if (message.toLowerCase().contains('user already exists')) {
          Navigator.pop(context);
          await login(
              {'email': data['email'], 'password': data['password']}, context);
        } else {
          throw AppException(message.isNotEmpty ? message : "signup_failed");
        }
      }
    } on AppException catch (e) {
      if (e.message.toLowerCase().contains('user already exists')) {
        if (context.mounted) Navigator.pop(context);
        await login(
            {'email': data['email'], 'password': data['password']}, context);
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          Mysnackbar.showError(context, e.message);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        Mysnackbar.showError(
          context,
          "something_went_wrong".tr(args: [e.toString()]),
        );
      }
    }
  }

  Future<void> login(Map<String, dynamic> data, BuildContext context) async {
    showLoader(context, "logging_in");

    try {
      final response = await _appService.login(data);

      if (response['success'] == true) {
        final token = response['token'] as String?;
        final userData = response['user'] as Map<String, dynamic>?;

        if (token == null || userData == null) {
          throw AppException("invalid_response_format");
        }

        userSD = UserModel.fromJson(userData);

        final storage = StorageService();
        await storage.setToken(token);
        await storage.setLogin(userSD!); // 💡 Use UserModel directly
        await FCMService().initializeAndSendToken(); // 👈 HERE
        await FCMHandler.setupNotificationHandlers(); // 👈 ADD THIS LINE

        if (context.mounted) {
          Navigator.pop(context);
          Mysnackbar.showSuccess(
            context,
            response['message'] ?? "login_successful",
          );

          await Future.delayed(const Duration(milliseconds: 100));
          try {
            // MyCustomNavigator.replace(context, const BottomBarNav());
          } catch (e) {
            Mysnackbar.showError(context, "navigation_error");
          }
        }
      } else {
        throw AppException(response['message'] ?? "login_failed");
      }
    } on AppException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        Mysnackbar.showError(context, e.message);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        Mysnackbar.showError(
          context,
          "something_went_wrong".tr(args: [e.toString()]),
        );
      }
    }
  }
}
