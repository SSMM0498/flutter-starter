# Flutter Starter

## Overview

This is a Flutter starter template that provides a solid foundation for building Flutter apps. It includes essential features such as authentication, state management, internationalization, and backend API integration. The project structure follows a modular approach, making it easy to organize and maintain your codebase. The starter template also includes sample code snippets for common Flutter tasks, making it easier to get started with Flutter development.

- 🧹 Clean and organized project structure- Ready-to-use configuration files
- 📦 Essential dependencies pre-configured
- 🏗️ Sample code snippets for common Flutter tasks
- 🔒 Authentication flow
  - 🚪 Login and registration screens
  - 🗝️ Password reset screen
  - 😁 User profile screen
  - ❓ Forgot password screen
  - ✉️ Email verification screen
  - 📢 Tiers Sign-In (Google, Facebook & GitHub)
- 🌜 Dark and light theme support
- 🌍 Internationalization (i18n) support
- 🗄️ Backend API integration (Firebase + Pocketbase)
- 💾 State management using GetX & Secure Storage

## Getting Started

To get started with this Flutter starter template, follow these steps:

1. Clone the repository: `git clone https://github.com/your-username/flutter-starter.git`
2. Install Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
3. Open the project in your favorite code editor
4. Run `flutter pub get` to install the project dependencies
5. Start building your Flutter app by customizing it!
   1. To customize the app's icons, theme, colors, fonts, etc., you can modify the `theme.dart` file in the `common/styles` directory. [color](starter\lib\common\styles\colors.dart)
   2. To add new dependencies or update existing ones, you can modify the `pubspec.yaml` file.
   3. To add new features or screens to the app, you can create new directories under the `features` directory and follow the existing structure.
   4. To add new routes or navigation logic, you can modify the `app_routes.dart` file in the `routes` directory.
   5. To add new utility functions, services, or data models, you can create new files or directories under the `core` or `data` directories.
   6. To add new custom widgets or styles, you can create new files or directories under the `common/widgets` or `common/styles` directories.

## Screenshots

|||
|:-:|:-:|
|||

## Project Structure

The project structure follows a modular approach, making it easy to organize and maintain your codebase. Here's an overview of the main directories:

- `lib`: Contains the main Dart code for your Flutter app
- `assets`: Stores static assets such as images, fonts, etc.
- `test`: Includes unit and widget tests for your app
- `android` and `ios`: Platform-specific code for Android and iOS respectively

The `lib` directory is further divided into the following subdirectories:
```
├─── 📂 common/
│   ├─── 📂 styles/
│   └─── 📂 widgets/
├─── 📂 core/
│   ├─── 📂 utils/
│   ├─── 📂 middleware/
│   └─── 📂 services/
├─── 📂 data/
│   ├─── 📂 repository/
│   └─── 📂 models/
├─── 📂 features/
│   ├─── 📂 authentication/
│   ├─── 📂 main/
│   └─── 📂 user/
├─── 📂 routes/
├─── 📄 app.dart
└─── 📄 main.dart
```

- `common`: Contains shared code that can be used across different parts of the app. This includes styles, themes, and custom widgets.
```
├─── 📂 common/
│   ├─── 📂 styles/
│   │   ├─── shadows_styles.dart
│   │   ├─── spacing_styles.dart
│   │   └─── theme.dart
│   └─── 📂 widgets/
│       ├─── 📂 app_bars/
│       ├─── 📂 custom_shapes/
│       ├─── 📂 icons/
│       ├─── 📂 images/
│       ├─── 📂 layouts/
│       ├─── 📂 shimmers/
│       └─── 📂 texts/
```
- `core`: Includes utility functions, middlewares, and services used throughout the app. This directory is further divided into three subdirectories:
  - `utils`: Contains utility functions for common tasks such as formatting, validation, logging, etc.
  - `middlewares`: Middleware functions for handling network requests, caching, etc.
  - `services`: Contains service classes for interacting with local storage, network requests, etc.
```
├─── 📂 core/
│   ├─── 📂 utils/
│   │   ├─── constants.dart
│   │   ├─── device_utils.dart
│   │   ├─── exceptions.dart
│   │   ├─── formatter_utils.dart
│   │   ├─── helpers.dart
│   │   ├─── http_utils.dart
│   │   ├─── logging_utils.dart
│   │   ├─── popups_utils.dart
│   │   ├─── request_utils.dart
│   │   └─── validators_utils.dart
│   ├─── 📂 middlewares/
│   └─── 📂 services/
│       ├─── 📂 local_storage/
│       ├─── 📂 network_service/
│       └─── 📂 pocketbase_service/
```
- `data`: Contains data models and repositories for handling data operations. This directory is further divided into two subdirectories:
  - `repository`: Contains repository classes for handling data operations such as fetching data from the network, local storage, etc.
  - `models`: Contains data models for representing entities such as users, items, etc.
```
├─── 📂 data
│   ├─── 📂 repository
│   │   ├─── 📂 authentication
│   │   ├─── 📂 item
│   │   └─── 📂 user
│   └─── 📂 models
│       ├─── 📂 item
│       └─── 📂 user
```
- `features`: Contains the main features of the app, such as authentication, user profile, etc. Each feature is further divided into three subdirectories:
  - `controllers`: Contains controller classes for managing the state and logic of the feature.
  - `models`: Contains data models specific to the feature.
  - `screens`: Contains the UI screens for the feature.
```
├─── 📂 features
│   ├─── 📂 authentication
│   │   ├─── 📂 controllers
│   │   ├─── 📂 models
│   │   └─── 📂 screens
│   ├─── 📂 main
│   │   ├─── 📂 controllers
│   │   ├─── 📂 models
│   │   └─── 📂 screens
│   └─── 📂 user
│       ├─── 📂 controllers
│       ├─── 📂 models
│       └─── 📂 screens
```
- `routes`: Defines the app's navigation routes and screens. This directory contains two files:
  - `app_routes.dart`: Contains the app's navigation routes.
  - `routes.dart`: Initializes the app's navigation and routes.
```
├─── 📂 routes
│   ├─── app_routes.dart
│   └─── routes.dart
```
- `app.dart`: The main entry point of the app where the app is initialized.
- `main.dart`: The starting point of the Flutter app.

## Dependencies

+ [Cached Network Image](https://pub.dev/packages/cached_network_image)
+ [Connectivity](https://pub.dev/packages/connectivity_plus)
+ [Dio](https://pub.dev/packages/dio)
+ [Facebook Login](https://pub.dev/packages/flutter_facebook_auth)
+ [Firebase](https://pub.dev/packages/firebase_core)
+ [Fluter Native Splash](https://pub.dev/packages/flutter_native_splash)
+ [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
+ [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
+ [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
+ [Flutter Shimmer](https://pub.dev/packages/shimmer)
+ [Flutter SVG](https://pub.dev/packages/flutter_svg)
+ [Flutter Toast](https://pub.dev/packages/fluttertoast)
+ [GetX](https://pub.dev/packages/get)
+ [GitHub Sign-In](https://pub.dev/packages/github_sign_in)
+ [Google Sign-In](https://pub.dev/packages/google_sign_in)
+ [HTTP](https://pub.dev/packages/http)
+ [Intl](https://pub.dev/packages/intl)
+ [Path Provider](https://pub.dev/packages/path_provider)
+ [Pocketbase](https://pub.dev/packages/pocketbase)

## Utils Commands

```sh
dart run flutter_native_splash:create
```

```sh
dart run flutter_launcher_icons
```