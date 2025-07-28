# android_chat_app

A Flutter-based Android application that combines group chatting, a robot price calculator, and a dataset collector for machine learning experiments.

## Description

This application provides a versatile platform with three main modules:

*   **Group Chat:** Enables real-time messaging among authenticated users.
*   **Robot Price Calculator:** A specialized tool to estimate the cost of robots based on selected components, aiding in budget planning and component selection.
*   **Dataset Collector:** Facilitates the collection and labeling of datasets, supporting machine learning model training and experimentation.

## Features

*   **User Authentication:** Secure user registration and login using Firebase Authentication.
*   **Real-time Group Chat:** Instant messaging with a dynamic UI for seamless communication.
*   **Robot Price Calculator:**
    *   Detailed component selection with real-time price updates.
    *   Model-based pricing for accurate cost estimation.
    *   Invoice generation for cost tracking and management.
*   **Dataset Collector:**
    *   Tools for collecting and labeling data.
    *   Customizable data schemas for various machine learning tasks.
    *   Data export options for model training pipelines.

## Getting Started

### Prerequisites

*   Flutter SDK installed.
*   Firebase project set up with Authentication and Firestore enabled.
*   Ensure you have FlutterFire CLI installed: `dart pub global activate flutterfire_cli`

### Installation

1.  Clone the repository:

    ```sh
    git clone <repository_url>
    ```
2.  Navigate to the project directory:

    ```sh
    cd android_chat_app
    ```
3.  Install dependencies:

    ```sh
    flutter pub get
    ```

### Firebase Configuration

1.  Run `flutterfire configure` in your terminal to link your Flutter project to your Firebase project.
2.  Ensure you have a `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) file in your project.
3.  Update `lib/firebase_options.dart` with your Firebase project's configuration.

### Running the App

```sh
flutter run
```

## Building and Running the Android APK

### Android Build Dependencies

Before building the Android APK, ensure you have the following dependencies installed:

*   **Android SDK:** The Android SDK provides the necessary tools and libraries to build, test, and debug apps for Android.
*   **Android Build Tools:** These tools are part of the Android SDK and are used for compiling and packaging Android apps.
*   **Java Development Kit (JDK):** Flutter requires a JDK to compile Java code. Ensure you have JDK 8 or later installed.
*   **Android Studio:** While not strictly required for building from the command line, Android Studio provides a convenient IDE and helps manage Android SDK dependencies.

You can manage these dependencies using Android Studio's SDK Manager.

### Building the APK

1.  **Build the APK:**

    Run the following command in the project directory to build the APK:

    ```sh
    flutter build apk
    ```

    This command generates an APK file in the `build/app/outputs/apk/release/app-release.apk` directory.

    For a signed APK (recommended for release), you'll need to configure signing keys. Refer to the Flutter documentation for details: [https://docs.flutter.dev/deployment/android#signing-the-app](https://docs.flutter.dev/deployment/android#signing-the-app)

### Running the APK

1.  **Connect an Android device or start an emulator.**
2.  **Install the APK:**

    You can install the APK on a connected device or emulator using the following command:

    ```sh
    flutter install
    ```

    Alternatively, you can manually install the APK using ADB (Android Debug Bridge):

    ```sh
    adb install build/app/outputs/apk/release/app-release.apk
    ```

    Make sure ADB is installed and configured on your system.

3.  **Run the app:**

    Once the APK is installed, you can launch the app from the device or emulator.

## Project Structure

```
android_chat_app/
├── android/                # Android-specific configuration
├── ios/                    # iOS-specific configuration
├── lib/
│   ├── component/          # Reusable widgets and components
│   ├── models/             # Data models
│   ├── pages/              # Application pages/screens
│   ├── services/           # Backend services (Firebase, APIs)
│   ├── states/             # State management (Providers, Notifiers)
│   ├── widgets/            # Custom widgets
│   ├── firebase_options.dart # Firebase configuration
│   └── main.dart           # Entry point of the application
├── assets/                 # Static assets (images, JSON files)
├── pubspec.yaml            # Project dependencies and metadata
├── README.md               # Project documentation
└── CONTRIBUTING.md         # Contribution guidelines
```

## Contributing

We welcome contributions! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## License

[MIT](LICENSE)
