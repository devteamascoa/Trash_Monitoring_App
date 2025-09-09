// ===============================================
// FORGOT PASSWORD SCREEN AND FORGOT PASSWORD CONFIRMATION SCREEN- Created by Michel
// Branch: feature/forgot-password
// Description: Screen for password reset functionality
// Usage: Navigated from LoginScreen forgot password button
// ===============================================

// ===============================================
// FORGOT PASSWORD SCREEN AND CONFIRMATION - Login Screen Styling
// ===============================================

import 'package:ascoa_app/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ascoa_app/app/routes/app_routes.dart';
import 'package:ascoa_app/shared/controllers/form_controllers.dart';
import 'package:ascoa_app/shared/controllers/validation_controller.dart';
import 'package:ascoa_app/shared/widgets/custom_input_field.dart';
import 'package:ascoa_app/shared/widgets/primary_button.dart';
import 'package:ascoa_app/shared/constants/app_colors.dart';
import 'package:ascoa_app/shared/constants/app_strings.dart';
import 'package:ascoa_app/shared/constants/app_text_styles.dart';
import 'package:ascoa_app/shared/constants/app_dimensions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Controllers
  late final AuthController controller;
  late final FormControllers formControllers;
  late final ValidationController validationController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    controller = Get.find<AuthController>();
    formControllers = Get.find<FormControllers>();
    validationController = Get.find<ValidationController>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Navigate to confirmation screen
  void _navigateToConfirmation(String email) {
    Get.toNamed(
      AppRoutes.forgotPasswordConfirmation,
      arguments: {'email': email},
    );
  }

  // Handle forgot password operation
  void _handleForgotPassword() {
    final isFrench = Get.locale?.languageCode == 'fr';

    // Validate email before sending
    validationController.validateEmail(formControllers.emailController.text);

    if (validationController.emailError.value == null &&
        formControllers.emailController.text.isNotEmpty) {
      controller
          .forgotPassword(formControllers.emailController.text)
          .then((result) {
            switch (result) {
              case 'success':
                _navigateToConfirmation(formControllers.emailController.text);
                break;
              case 'user-not-found':
                _showErrorSnackbar(
                  isFrench
                      ? 'Aucun utilisateur trouvé avec cette adresse email.'
                      : 'No user found with this email address.',
                );
                break;
              case 'invalid-email':
                _showErrorSnackbar(
                  isFrench
                      ? 'Adresse email invalide.'
                      : 'Invalid email address.',
                );
                break;
              case 'too-many-requests':
                _showErrorSnackbar(
                  isFrench
                      ? 'Trop de tentatives. Réessayez plus tard.'
                      : 'Too many attempts. Try again later.',
                );
                break;
              default:
                _showErrorSnackbar(
                  isFrench
                      ? 'Une erreur est survenue. Réessayez plus tard.'
                      : 'An error occurred. Try again later.',
                );
            }
          })
          .catchError((error) {
            _showErrorSnackbar(
              isFrench
                  ? 'Une erreur est survenue. Réessayez plus tard.'
                  : 'An error occurred. Try again later.',
            );
          });
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isFrench = Get.locale?.languageCode == 'fr';

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: AppColors.primary, // Same as login screen - white background
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.screenPadding,
              vertical: AppDimensions.verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Button - Styled like login screen
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color:
                          AppColors.buttonPrimary, // Green color matching login
                      size: 28,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),

                SizedBox(height: size.height * AppDimensions.titleTopSpacing),

                // Title - Same style as login
                Text(
                  isFrench ? 'Mot de passe oublié' : 'Forgot Password',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1, // Same as login screen
                ),

                SizedBox(height: size.height * AppDimensions.inputSpacing),

                // Subtitle
                Text(
                  isFrench
                      ? 'Nous vous enverrons par email\nun lien pour réinitialiser votre mot de passe.'
                      : 'We will email you\na link to reset your password.',
                  style: AppTextStyles.bodySecondary, // Same as login screen
                  textAlign: TextAlign.center,
                ),

                SizedBox(
                  height: size.height * AppDimensions.titleBottomSpacing,
                ),

                // Email Label - EXACTLY like login screen
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isFrench ? 'Votre Email' : 'Your Email',
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.smallSpacing),

                // Email Input Field - EXACTLY like login screen using CustomInputField
                Obx(
                  () => CustomInputField(
                    controller: formControllers.emailController,
                    hint: AppStrings.emailHint,
                    obscure: false,
                    errorText: validationController.emailError.value,
                    onChanged: validationController.validateEmail,
                  ),
                ),

                SizedBox(height: size.height * AppDimensions.buttonSpacing),

                // Send Reset Link Button - Using PrimaryButton like login
                Obx(
                  () => PrimaryButton(
                    label:
                        controller.isLoadingForgotPassword.value
                            ? (isFrench ? 'Envoi en cours...' : 'Sending...')
                            : (isFrench
                                ? 'Envoyer le lien'
                                : 'Send Reset Link'),
                    onPressed:
                        controller.isLoadingForgotPassword.value
                            ? () {} // Empty function instead of null
                            : _handleForgotPassword,
                  ),
                ),

                // SizedBox(height: size.height * 0.1),

                // // Terms and Privacy Policy - Same style as login
                // RichText(
                //   textAlign: TextAlign.center,
                //   text: TextSpan(
                //     style: AppTextStyles.termsBase, // Same as login
                //     children: [
                //       TextSpan(
                //         text:
                //             isFrench
                //                 ? 'En utilisant ASCOA, vous acceptez les '
                //                 : 'By using ASCOA, you agree to the ',
                //       ),
                //       const TextSpan(
                //         text: 'Terms',
                //         style: AppTextStyles.termsLink, // Same as login
                //       ),
                //       TextSpan(text: isFrench ? ' et ' : ' and '),
                //       const TextSpan(
                //         text: 'Privacy Policy',
                //         style: AppTextStyles.termsLink, // Same as login
                //       ),
                //       const TextSpan(text: '.'),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================================
// FORGOT PASSWORD CONFIRMATION SCREEN
// ===============================================

class ForgotPasswordConfirmationScreen extends StatelessWidget {
  final String email;

  const ForgotPasswordConfirmationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isFrench = Get.locale?.languageCode == 'fr';

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: AppColors.primary, // Same white background as login
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.screenPadding,
              vertical: AppDimensions.verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * AppDimensions.titleTopSpacing),

                // Title
                Text(
                  isFrench ? 'Mot de passe oublié' : 'Forgot Password',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1,
                ),

                SizedBox(height: size.height * 0.08),

                // Email Icon
                // Container(
                //   width: 80,
                //   height: 80,
                //   decoration: BoxDecoration(
                //     color: AppColors.buttonPrimary.withOpacity(0.1), // Light green
                //     shape: BoxShape.circle,
                //   ),
                //   child: Icon(
                //     Icons.email_outlined,
                //     size: 40,
                //     color: AppColors.buttonPrimary, // Green color
                //   ),
                // ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.buttonPrimary70,
                        AppColors.buttonPrimary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.buttonPrimary40,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mark_email_read,
                    size: 40,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: size.height * AppDimensions.paragraphSpacing),

                // Confirmation Message
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.bodySecondary,
                    children: [
                      TextSpan(
                        text:
                            isFrench
                                ? 'Nous avons envoyé un email\nà '
                                : 'We have sent an email\nto ',
                      ),
                      TextSpan(
                        text: email,
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text:
                            isFrench
                                ? ' avec des instructions\npour réinitialiser votre mot de passe.'
                                : ' with instructions\nto reset your password.',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * AppDimensions.paragraphSpacing),

                // Back to Login Button - Using PrimaryButton
                PrimaryButton(
                  label: isFrench ? 'Retour à la connexion' : 'Back to Login',
                  onPressed: () {
                    // Navigate back to login (remove all previous screens)
                    Get.offAllNamed(AppRoutes.login);
                  },
                ),

                // SizedBox(height: size.height * 0.1),

                // // Terms and Privacy Policy
                // RichText(
                //   textAlign: TextAlign.center,
                //   text: TextSpan(
                //     style: AppTextStyles.termsBase,
                //     children: [
                //       TextSpan(
                //         text:
                //             isFrench
                //                 ? 'En utilisant ASCOA, vous acceptez les '
                //                 : 'By using ASCOA, you agree to the ',
                //       ),
                //       const TextSpan(
                //         text: 'Terms',
                //         style: AppTextStyles.termsLink,
                //       ),
                //       TextSpan(text: isFrench ? ' et ' : ' and '),
                //       const TextSpan(
                //         text: 'Privacy Policy',
                //         style: AppTextStyles.termsLink,
                //       ),
                //       const TextSpan(text: '.'),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================================
// END FORGOT PASSWORD SCREENS
// ===============================================
