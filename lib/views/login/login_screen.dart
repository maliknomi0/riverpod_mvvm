import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpordmvvm/providers/login_provider.dart';
import 'package:riverpordmvvm/view_models/login/login_vm.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

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
                if (loginVM.status == LoginStatus.error)
                  Text(
                    loginVM.errorMsg ?? 'Login failed',
                    style: const TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  onPressed: (loginVM.status == LoginStatus.loading)
                      ? null
                      : () {
                          final email = emailCtrl.text.trim();
                          final password = passCtrl.text.trim();

                          if (!EmailValidator.validate(email)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid email!')),
                            );
                            return;
                          }
                          if (password.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password too short!'),
                              ),
                            );
                            return;
                          }

                          ref.read(loginVMProvider).login(email, password);
                        },
                  child: loginVM.status == LoginStatus.loading
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),
                if (loginVM.status == LoginStatus.success)
                  const Text("Login Success!"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
