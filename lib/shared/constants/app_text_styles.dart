import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Font Families
  static const String inter = 'Inter';
  static const String roboto = 'Roboto';

  // Heading Styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: inter,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    color: AppColors.white,
  );

  // Label Styles
  static const TextStyle label = TextStyle(
    fontFamily: roboto,
    fontSize: 16,
    color: AppColors.white,
  );

  // Body Styles
  static const TextStyle body = TextStyle(
    fontFamily: inter,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.white,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontFamily: inter,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.white70,
  );

  // Button Styles
  static const TextStyle buttonLink = TextStyle(
    fontFamily: inter,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.white,
    decoration: TextDecoration.underline,
    decorationThickness: 2.0,
    decorationColor: AppColors.white,
  );

  // Divider Text
  static const TextStyle dividerText = TextStyle(
    fontFamily: inter,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.white,
  );

  // Terms Text Styles
  static const TextStyle termsBase = TextStyle(
    fontFamily: roboto,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.white,
    height: 1.6, // 160% line height
  );

  static const TextStyle termsLink = TextStyle(
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.white,
  );

  // Prevent instantiation
  AppTextStyles._();
}
