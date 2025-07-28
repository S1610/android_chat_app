# android_chat_app

This is the main README for the Android Chat App.

## Getting Started

=======
# simple_android# android_chat_app
>>>>>>> 3ce4ab4487c20f6a1addd13a6c6a3d21dcc3aab9

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

## Contributing

We welcome contributions! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## License

[MIT](LICENSE)
