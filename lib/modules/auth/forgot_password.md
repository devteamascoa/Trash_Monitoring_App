# Forgot Password Feature – ASCOA App

## Purpose

Allows users to request a password reset link via email. Integrates with **AuthController** and uses **GetX** for state management. Supports **English** and **French** automatically.

---

## Key Components

### Screens

- **ForgotPasswordScreen**  
  - Input: Email  
  - Features: Real-time email validation, loading state, bilingual labels/messages  
  - Action: Sends password reset request via `AuthController`

- **ForgotPasswordConfirmationScreen**  
  - Displays the email address where the reset link was sent  
  - Shows confirmation message in English or French

### Controllers

- **AuthController**  
  - `RxBool isLoadingForgotPassword` – tracks loading state  
  - `Future<String> forgotPassword(String email)` – sends reset email  
  - Returns:  
    - `'success'` → Email sent  
    - `'user-not-found'` → No user found  
    - `'invalid-email'` → Invalid email format  
    - `'too-many-requests'` → Rate limit  
    - `'error'` → General Firebase error  

- **FormControllers** – Manages `emailController` for input  
- **ValidationController** – Validates email in real-time and sets error messages

---

### Full Flow

```dart
// Navigate to Forgot Password screen
Get.toNamed(AppRoutes.forgotPassword);

// Navigate to Confirmation screen with email argument
Get.toNamed(
  AppRoutes.forgotPasswordConfirmation,
  arguments: {'email': 'user@example.com'},
);
```

### Controller Only

```dart
final AuthController authController = Get.find<AuthController>();
final result = await authController.forgotPassword('user@example.com');

if(result == 'success'){
  Get.toNamed(
    AppRoutes.forgotPasswordConfirmation,
    arguments: {'email': 'user@example.com'},
  );
}
```

### Confirmation Screen Only

```dart
Get.toNamed(
  AppRoutes.forgotPasswordConfirmation,
  arguments: {'email': 'user@example.com'},
);
```

---

## Features

* Real-time email validation with error feedback
* Loading state disables button during request
* Bilingual support (English/French) using `Get.locale`
* Error handling via snackbars
* Modern UI matching app color scheme
* Footer includes Terms & Privacy Policy
