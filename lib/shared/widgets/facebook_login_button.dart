import 'package:flutter/material.dart';

class FacebookLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FacebookLoginButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/Facebook/Facebook_Logo_Primary.png',
        height: 60,
      ),
      onPressed: onPressed,
      tooltip: 'Sign in with Facebook',
    );
  }
}
