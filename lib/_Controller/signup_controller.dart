import 'package:flutter/material.dart';
import 'package:zene/_Models/user_model.dart';
import 'package:zene/Utils/mysnackbar.dart';
import 'package:zene/Utils/app_exceptions.dart';
import 'package:zene/Utils/loading.dart';
import 'package:zene/services/app_services.dart';
import 'package:zene/services/storage.dart';
import 'package:zene/global/globle.dart';
import 'package:zene/_views/Screens/initals/login/login.dart';
import 'package:zene/_views/widgets/my_custom_navigator.dart';

class SignupController extends ChangeNotifier {
  final AppService _appService = AppService();

  Future<void> signup(Map<String, dynamic> data, BuildContext context) async {
    showLoader(context, "Signing you up...");

    try {
      final response = await _appService.signup(data);

      assert(() {
        debugPrint("[DEBUG] Signup Response: $response");
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
          response['message'] ?? "Signup successful",
        );

        MyCustomNavigator.removeUntil(context, const Login());
      } else {
        final message = response['message'] ?? "Signup failed";
        Navigator.pop(context);
        Mysnackbar.showError(context, message);
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
