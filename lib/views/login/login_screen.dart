import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/providers/login_provider.dart';
import 'package:riverpordmvvm/view_models/login/login_vm.dart';
import 'package:riverpordmvvm/widgets/my_snackbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.listen<LoginVM>(loginVMProvider, (previous, next) {
      if (next.status == LoginStatus.error) {
        mysnackbar.showError(context, next.errorMsg ?? 'Login failed');
      } else if (next.status == LoginStatus.success) {
        mysnackbar.showSuccess(context, 'Login Success!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginVM = ref.watch(loginVMProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: (loginVM.status == LoginStatus.loading)
                      ? null
                      : () {
                          final email = emailCtrl.text.trim();
                          final password = passCtrl.text.trim();

                          if (!EmailValidator.validate(email)) {
                            mysnackbar.showError(context, 'Invalid email!');
                            return;
                          }
                          if (password.length < 6) {
                            mysnackbar.showError(
                              context,
                              'Password too short!',
                            );
                            return;
                          }

                          ref.read(loginVMProvider).login(email, password);
                        },
                  child: loginVM.status == LoginStatus.loading
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
