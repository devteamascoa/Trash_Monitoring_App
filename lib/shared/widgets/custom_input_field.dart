import 'package:flutter/material.dart';
import 'package:ascoa_app/shared/constants/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final String? Function(String?)? validator;
  final String? errorText;

  const CustomInputField({
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.validator,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color:
                  errorText != null
                      ? Colors.red
                      : AppColors.accent, // Green border
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              hintStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                color: AppColors.textHint, // Use consistent hint color
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ],
    );
  }
}
