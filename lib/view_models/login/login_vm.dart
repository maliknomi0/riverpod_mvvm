import 'package:flutter/material.dart';

import '../../core/storage/hive_storage_helper.dart';
import '../../repositories/auth_repository.dart';

enum LoginStatus { idle, loading, success, error }

class LoginVM extends ChangeNotifier {
  final AuthRepository repo;
  LoginVM(this.repo);

  LoginStatus status = LoginStatus.idle;
  String? errorMsg;

  Future<void> login(String email, String password) async {
    status = LoginStatus.loading;
    errorMsg = null;
    notifyListeners();

    try {
      final (token, user) = await repo.login(email, password);
      await HiveStorageHelper.saveToken(token);
      await HiveStorageHelper.saveUser(user);

      status = LoginStatus.success;
      notifyListeners();
    } catch (e) {
      status = LoginStatus.error;
      errorMsg = e.toString();
      notifyListeners();
    }
  }

  void reset() {
    status = LoginStatus.idle;
    errorMsg = null;
    notifyListeners();
  }
}
