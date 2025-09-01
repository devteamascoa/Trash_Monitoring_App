import 'package:flutter/material.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleLoginButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/Google/android_light_rd_na@2x.png', height: 60),
      onPressed: onPressed,
      tooltip: 'Sign in with Google',
    );
  }
}
