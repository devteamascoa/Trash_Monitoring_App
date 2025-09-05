import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const SocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFA9D0F5), width: 3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 32, height: 32, child: icon),
            const SizedBox(width: 18),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3A383F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
