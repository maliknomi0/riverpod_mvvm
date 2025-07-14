import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zene/_Controller/EditProfileController.dart';
import 'package:zene/_Models/user_model.dart';
import 'package:zene/Utils/mysnackbar.dart';
import 'package:zene/Utils/app_exceptions.dart';
import 'package:zene/Utils/loading.dart';
import 'package:zene/services/app_services.dart';
import 'package:zene/services/storage.dart';
import 'package:zene/global/globle.dart';
import 'package:zene/_views/Screens/bottom_bar/bottom_bar.dart';
import 'package:zene/_views/widgets/my_custom_navigator.dart';

class LoginController extends ChangeNotifier {
  final AppService _appService = AppService();

  Future<void> login(Map<String, dynamic> data, BuildContext context) async {
    showLoader(context, "Logging in...");

    try {
      final response = await _appService.login(data);

      // Debug log
      assert(() {
        debugPrint("[DEBUG] Login Response: $response");
        return true;
      }());

      if (response['success'] == true &&
          response['token'] != null &&
          response['user'] != null) {
        final token = response['token'] as String;
        final userData = response['user'] as Map<String, dynamic>;

        userSD = UserModel.fromJson(userData);

        final storage = Storage();
        await storage.setToken(token);
        await storage.setLogin(userData);

        Navigator.pop(context);
        Mysnackbar.showSuccess(
          context,
          response['message'] ?? "Login successful",
        );

        if (context.mounted) {
          Provider.of<EditProfileController>(
            context,
            listen: false,
          ).refreshUserData();
        }

        MyCustomNavigator.removeUntil(context, BottomNav());
      } else {
        Navigator.pop(context);
        Mysnackbar.showError(context, response['message'] ?? "Login failed");
      }
    } on AppException catch (e) {
      Navigator.pop(context);
      Mysnackbar.showError(context, e.message);
    } catch (e) {
      Navigator.pop(context);
      Mysnackbar.showError(context, "Something went wrong: $e");
    }
  }
}
