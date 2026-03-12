# Vibe In

Vibe In is a Flutter mobile application for browsing curated products and packages, authenticating users with OTP, and moving through a lightweight shopping flow that includes home discovery, product filtering, package details, cart, checkout, and order-related screens.

This repository is structured as a portfolio-ready codebase with clear feature boundaries, environment-based entry points, dependency injection, generated API clients, localization support, and automated testing across business logic and UI.

## Highlights

- OTP-based authentication flow
- Feature-first folder structure
- `Cubit` state management with `flutter_bloc`
- Repository layer between presentation and networking
- `Dio + Retrofit` for typed API integration
- `GetIt` for dependency injection
- Multi-flavor setup: `development`, `staging`, `production`
- Localization with `easy_localization`
- Unit, widget, and integration test coverage

## Feature Overview

The current codebase includes:

- Onboarding
- Login with mobile number
- OTP verification
- Home shell with bottom navigation
- Main page content: sliders, best sellers, packages
- Products listing with categories and filters
- Best seller screen
- Packages listing and package details
- Profile screen
- Orders and order details screens
- Cart and checkout screens

## Tech Stack

- Flutter
- Dart 3
- `flutter_bloc`
- `get_it`
- `dio`
- `retrofit`
- `json_serializable`
- `easy_localization`
- `shared_preferences`
- `flutter_secure_storage`
- Firebase Core

## Architecture

The app follows a pragmatic layered architecture inside a feature-first structure:

1. `UI`
   Screens and widgets render the interface and react to state updates.
2. `Cubit`
   Each feature owns its presentation state and business-flow orchestration.
3. `Repository`
   Repositories isolate data access from UI state management.
4. `ApiService`
   A Retrofit-generated API contract sits on top of `Dio`.
5. `Models`
   Request/response models are serialized with generated code.

In practice, most features follow this shape:

```text
feature/
├── cubit/
├── data/
│   ├── models/
│   └── repo/
└── ui/
    └── widgets/
```

### Why this architecture works well here

- UI stays focused on rendering and user interaction.
- Cubits remain easy to test because side effects are delegated to repositories.
- Repositories keep API details away from presentation code.
- Dependency registration is centralized in `lib/core/di/dependency_injection.dart`.
- Networking stays consistent because all endpoints are defined in one Retrofit service.

## Project Structure

```text
lib/
├── core/
│   ├── di/
│   ├── helpers/
│   ├── networking/
│   ├── routing/
│   ├── theming/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── best_seller_screen/
│   ├── bottom_nav_bar/
│   ├── cart/
│   ├── checkout_screen/
│   ├── order_details/
│   ├── package_details/
│   ├── packages_screen/
│   └── product_details/
├── bloc_observer.dart
├── env.dart
├── main_dev.dart
├── main_stag.dart
├── main_prod.dart
└── vibe_in_app.dart
```

## State Management

The app uses `Cubit` from `flutter_bloc`.

Examples in the codebase:

- `LoginCubit` handles phone number submission and OTP request state
- `VerificationCubit` manages OTP verification, countdown timer, and resend flow
- `MainPageCubit` loads sliders, best sellers, and packages
- `ProductsCubit` manages categories, filters, pagination, and tab switching

`Bloc.observer` is enabled through `MyBlocObserver` to make transitions easier to inspect during development.

## Networking

Networking is handled through:

- `DioFactory` for shared `Dio` configuration
- `ApiService` for typed Retrofit endpoints
- generated files such as `api_service.g.dart`
- a shared API response wrapper for paginated/list responses

Current API capabilities in the service include:

- send OTP
- verify OTP
- onboarding data
- logout
- sliders
- profile
- best sellers
- packages
- single package details
- categories
- products

Authentication tokens are persisted using `flutter_secure_storage`, while lightweight flags such as onboarding state are stored in `shared_preferences`.

## Routing

Navigation is centralized in `lib/core/routing/app_router.dart`.

The router wires screens with their required `BlocProvider` or `MultiBlocProvider`, which keeps screen setup explicit and avoids hidden dependencies inside widgets.

## Environments and Flavors

The project supports three environments:

- `development`
- `staging`
- `production`

Each environment has:

- a dedicated Flutter entry point
- its own base URL via `.env`
- flavor-specific Firebase configuration

### Entry points

- `lib/main_dev.dart`
- `lib/main_stag.dart`
- `lib/main_prod.dart`

### Expected `.env` keys

```env
API_BASE_URL_DEV=...
API_BASE_URL_STAG=...
API_BASE_URL=...
```

### Android flavor configuration

Android flavors are defined in `android/app/build.gradle.kts`:

- `development` with application ID suffix `.dev`
- `staging` with application ID suffix `.stg`
- `production` without suffix

Firebase JSON files are expected under:

```text
android/app/src/development/google-services.json
android/app/src/staging/google-services.json
android/app/src/production/google-services.json
```

### iOS flavor configuration

The iOS project includes development, staging, and production schemes, plus flavor-specific Firebase plist files under:

```text
ios/Runner/Config/development/GoogleService-Info.plist
ios/Runner/Config/staging/GoogleService-Info.plist
ios/Runner/Config/production/GoogleService-Info.plist
```

## Localization

The app uses `easy_localization` with English and Arabic support.

- Translation files live in `assets/translations/`
- Supported locales are initialized at app startup
- English is currently configured as the fallback and start locale

## Responsive UI and Design System

The app includes a small internal UI foundation:

- shared theme configuration in `core/theming`
- app-wide color, sizing, string, and typography helpers
- `SizeProvider` and screen extension helpers for responsive sizing
- reusable widgets across features

## Dependency Injection

Dependencies are registered in `lib/core/di/dependency_injection.dart` using `GetIt`.

This includes:

- `ApiService`
- repositories
- cubits

The project uses both:

- `registerLazySingleton` for shared long-lived dependencies
- `registerFactory` for fresh instances when needed

## Code Generation

The project uses generated code for:

- Retrofit clients
- JSON serialization

Run this command after changing API contracts or serializable models:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Getting Started

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Create the environment file

Add a `.env` file to the project root:

```env
API_BASE_URL_DEV=https://your-dev-api.example.com/
API_BASE_URL_STAG=https://your-staging-api.example.com/
API_BASE_URL=https://your-production-api.example.com/
```

### 3. Add Firebase config per flavor

Place the correct Firebase configuration files for Android and iOS in their flavor-specific locations.

### 4. Generate code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Run the app

Development:

```bash
flutter run --debug -t lib/main_dev.dart --flavor development
```

Staging:

```bash
flutter run --debug -t lib/main_stag.dart --flavor staging
```

Production:

```bash
flutter run --release -t lib/main_prod.dart --flavor production
```

## Testing

The project includes three testing layers:

### Unit tests

Unit tests focus on Cubit behavior and state transitions.

Examples:

- login success and error states
- OTP verification success, validation errors, and server failures
- home and bottom navigation state behavior
- main page loading states for sliders, best sellers, and packages
- products filtering, category selection, and pagination behavior

### Widget tests

Widget tests validate important UI states and interactions, such as:

- login screen rendering
- form validation messages
- verification screen rendering
- timeout and resend behavior

### Integration test

An end-to-end login flow exists in:

```text
integration_test/login_flow_test.dart
```

It covers the high-level path:

`Login -> OTP -> Home`

### Test approach

One detail worth highlighting in this project is how feature Cubits are tested:

- a temporary local mock server is started with `shelf`
- `Dio` points to that server during the test
- the mocked API returns controlled success or failure payloads
- Cubit state emissions are asserted using `bloc_test`

This keeps tests close to real networking behavior without depending on a live backend.

### Commands

Run the main automated suite:

```bash
flutter test
```

Run the integration test separately on a selected device:

```bash
flutter test integration_test/login_flow_test.dart -d <deviceId>
```

### Verification status

I verified the main automated test suite locally with:

```bash
flutter test
```

Result:

- `44` tests passed

The standalone integration test file is present, but running it separately requires choosing a concrete target device because this environment exposed multiple targets (`macOS` and `Chrome`) and no single active device was selected.

## CI/CD

The repository already includes a GitHub Actions workflow in `.github/workflows/main.yml`.

### What the pipeline does

- runs on pushes to `development`, `staging`, and `master`
- runs on pull requests targeting `development`
- installs Flutter `3.29.0`
- restores dependency and Gradle caches
- runs `flutter pub get`
- runs code generation with `build_runner`
- creates the `.env` file from GitHub Secrets
- decodes Firebase config files from GitHub Secrets
- runs unit and widget tests with `flutter test`
- runs integration tests on an Android emulator for `development` and `staging`
- builds a flavor-specific APK
- uploads the APK as a GitHub Actions artifact
- creates a GitHub Release for `master`
- distributes the staging APK through Firebase App Distribution
- sends a Slack notification for every run result

### Branch behavior

- `development`: debug build, tests, integration tests
- `staging`: release build, tests, integration tests, Firebase App Distribution
- `master`: production release build, artifact upload, GitHub Release

### Repository automation extras

The repository also includes:

- `.github/pull_request_template.md` for pull request consistency

## Notes for Open-Sourcing

Before publishing this repository publicly, it is worth checking:

- remove any real API base URLs from `.env`
- confirm no production secrets are committed
- verify Firebase configuration files are safe to expose for your use case
- consider adding screenshots or a short demo GIF
- consider adding CI for `flutter analyze` and `flutter test`

## Possible Next Improvements

- add golden tests for critical screens
- add a dedicated fake data layer for demo mode
- include screenshots in the README

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
