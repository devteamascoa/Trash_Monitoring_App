import 'package:ascoa_app/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ascoa_app/shared/controllers/form_controllers.dart';
import 'package:ascoa_app/shared/widgets/google_login_button.dart';
import 'package:ascoa_app/shared/widgets/facebook_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
    final FormControllers formControllers = Get.find<FormControllers>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: formControllers.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: formControllers.passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.login(
                    formControllers.emailController.text,
                    formControllers.passwordController.text,
                  );
                },
                child: const Text('Login'),
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to signup
              },
              child: const Text("Don't have an account? Sign up"),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleLoginButton(
                  onPressed: () {
                    controller.loginWithGoogle();
                  },
                ),
                const SizedBox(width: 16),
                FacebookLoginButton(
                  onPressed: () {
                    controller.loginWithFacebook();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
