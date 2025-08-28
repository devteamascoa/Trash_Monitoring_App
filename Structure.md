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

---

### `modules/`

Feature-based folders. Each feature is self-contained with its own screens, widgets, and bindings.

Typical structure inside a module:

- **views/** → Screens for the feature.
- **widgets/** → Reusable widgets specific to that feature.
- **bindings/** → Dependency injection for controllers/services.

Examples of modules: `auth/`, `home/`, `profile/`, `posts/`, `search/`, `settings/`.

---

### `shared/`

Holds everything that can be reused across multiple modules.

- **widgets/** → Common UI components (buttons, inputs, loaders).
- **constants/** → Central values like colors, strings, dimensions.
- **utils/** → Helper functions (validators, formatters, date helpers).
- **themes/** → Light/dark theme setup and text styles.

---
