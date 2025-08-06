import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/core/network/app_services.dart';
import 'package:riverpordmvvm/repositories/auth_repository.dart';
import 'package:riverpordmvvm/view_models/login/login_vm.dart';

final apiServiceProvider = Provider<AppService>((ref) => AppService());

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(apiServiceProvider)), // always ref.read()
);

final loginVMProvider = ChangeNotifierProvider<LoginVM>(
  (ref) => LoginVM(ref.read(authRepositoryProvider)), // always ref.read()
);
