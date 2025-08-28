# 📂 Project Structure

This project uses a **modular architecture** with `GetX` for state management, navigation, and dependency injection.  
The structure ensures **separation of concerns**, **reusability**, and easy scalability.

```plaintext
lib/
│
├── main.dart
│
├── app/                     # Core app setup
│   ├── routes/              # Global navigation setup
│   │   └── app_routes.dart
│   ├── controllers/         # Global state controllers
│   │   └── auth_controller.dart
│   ├── services/            # Firebase/API services
│   │   └── auth_service.dart
│   └── models/              # Global models (User, Post, etc.)
│
├── modules/                 # Feature-based modules
│   ├── auth/                # Login/Signup
│   │   ├── views/           # Screens
│   │   │   ├── login_screen.dart
│   │   │   └── signup_screen.dart
│   │   ├── widgets/         # Widgets used inside auth
│   │   └── auth_binding.dart
│   │
│   ├── home/                # Home/dashboard
│   │   └── views/
│   │       └── home_screen.dart
│   │
│   ├── profile/             # User profile
│   │   └── views/
│   │       └── profile_screen.dart
│   │
│   ├── posts/               # Posts/feed
│   │   ├── views/
│   │   │   ├── post_list_screen.dart
│   │   │   └── post_detail_screen.dart
│   │   └── widgets/
│   │
│   ├── search/              # Search feature
│   │   └── views/
│   │       └── search_screen.dart
│   │
│   └── settings/            # Settings
│       └── views/
│           └── settings_screen.dart
│
└── shared/                  # Reusable across modules
    ├── widgets/             # Buttons, text fields, loaders
    ├── constants/           # Colors, strings, sizes
    ├── utils/               # Validators, formatters, helpers
    └── themes/              # Light/dark theme, text styles
```

# 📂 Folder Guide

A quick overview of the project structure and what goes where:

---

### `main.dart`

- Entry point of the app.
- Sets up the root widget and initializes required bindings/services.

---

### `app/`

Core setup that holds global app logic.

- **routes/** → Centralized navigation (all `GetPages` live here).
- **controllers/** → Global state controllers (e.g. auth).
- **services/** → Firebase/API wrappers and other external services.
- **models/** → Shared data models used across features (e.g. `User`, `Post`).

### Controllers vs Services

- **Controllers** → Manage the app’s **state and UI logic**.  
  They handle how data flows between your views (screens) and services.  
  Example: `AuthController` listens to login inputs, calls the `AuthService` to verify the user, and then updates the UI.

- **Services** → Handle **external operations** like API calls, Firebase auth, or database access.  
  They don’t know about the UI; they just provide raw data or results.

👉 Think of it like this:  
**Service = "Go fetch/store the data"**  
**Controller = "Decide what to do with that data and show it to the user"**

---

### `modules/`

Feature-based folders. Each feature is self-contained with its own screens, widgets, and bindings.

Typical structure inside a module:

- **views/** → Screens for the feature.
- **widgets/** → Reusable widgets specific to that feature. Like a Login form widget for the login screen, because its only used in the login screen we do not put it in the shared widgets library.
- **bindings/** → Dependency injection for controllers/services. See [Bindings in GetX](#-bindings-in-getx)

Examples of modules: `auth/`, `home/`, `profile/`, `posts/`, `search/`, `settings/`.

---

### `shared/`

Holds everything that can be reused across multiple modules.

- **widgets/** → Common UI components (buttons, inputs, loaders).
- **constants/** → Central values like colors, strings, dimensions. This is good so that we dont have to keep defining colours, we can just define them once and use them everywhere.
- **utils/** → Helper functions (validators, formatters, date helpers). Example: a password strength shecker which validates the strench of the password
- **themes/** → Light/dark theme setup and text styles.(Optional)

---

### 🔗 Bindings in GetX

Bindings in GetX are a clean way to manage dependency injection. Instead of creating controllers or services directly inside your UI files, you declare them once in a Binding. When a route loads, GetX automatically initializes the required dependencies and disposes of them when the route is removed. This keeps your code organized, avoids repeating initialization logic everywhere, and makes it easier to scale when controllers need new dependencies.

<details>
  <summary>📌 Example (click to expand)</summary>

```dart
// auth_binding.dart
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

// main.dart
GetMaterialApp(
  initialRoute: '/login',
  getPages: [
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(), // (2) Injects AuthController automatically
    ),
  ],
);
// login_screen.dart
class LoginScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();
  // This won’t be needed because we already injected it in (2)
  // With Bindings, we inject AuthController once in AuthBinding and can fetch it anywhere it’s needed.
  // Without Bindings, we would have to manually create or put the controller in every screen that uses it,
  // which can lead to repetitive code and potential memory leaks.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(controller.title),
      ),
    );
  }
}
```
