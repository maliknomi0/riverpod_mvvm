import 'package:riverpordmvvm/core/network/app_services.dart';

import '../models/user_model.dart';

class AuthRepository {
  final AppService api;

  AuthRepository(this.api);

  Future<(String token, UserModel user)> login(String email, String password) async {
    final response = await api.login({'email': email, 'password': password});
    if (response['success'] == true) {
      final token = response['token'] as String?;
      final userData = response['user'] as Map<String, dynamic>?;

      if (token != null && userData != null) {
        return (token, UserModel.fromJson(userData));
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      throw Exception(response['message'] ?? "Login failed");
    }
  }
}
