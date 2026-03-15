# Chatbot
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Ahmed-khedrovica/chatbot)

This is a sophisticated chatbot application built with Flutter, powered by Google's Gemini API. The project is designed with a focus on clean architecture, robust state management, and comprehensive testing, serving as a strong example of a production-quality Flutter application.

## Features

- **Gemini API Integration**: Leverages Google's Gemini API for intelligent and dynamic conversational responses.
- **Clean Architecture**: Adheres to a feature-driven, layered architecture (Data, Domain, UI) for maintainability and scalability.
- **State Management with BLoC**: Utilizes `flutter_bloc` (specifically Cubit) for predictable and efficient state management.
- **Robust Networking**: Includes a resilient API service with automatic retries for transient network failures.
- **Polished Chat UI**: A responsive user interface that provides clear feedback for different message states: loading (typing indicator), success, and failure (with a resend option).
- **Comprehensive Testing**: A full suite of tests ensures code quality and reliability:
    - **Unit Tests** using `mocktail` for validating business logic.
    - **Integration Tests** using `patrol` for end-to-end user flow verification.

## Architecture

The project follows a clean, feature-centric architecture to ensure a distinct separation of concerns.

-   **`lib/core`**: Contains shared components across the application, such as the `Dio` API client, dependency injection setup (`get_it`), and custom BLoC observers.
-   **`lib/features`**: Each feature is a self-contained module. The `chat` feature is structured into three main layers:
    -   **`data`**: Handles data operations. Includes data models, repository implementations (`GemenaiChatRepoImpl`), and the API service (`GemenaiChatService`) that communicates with the Gemini API.
    -   **`domain`**: Contains the abstract business logic and contracts, such as the `ChatRepo` abstract class.
    -   **`ui`**: Manages the presentation layer, including screens, widgets, and state management logic via `SendMessageCubit`.

Dependency injection is managed by the `get_it` package, which initializes and provides services, repositories, and cubits throughout the app.

## Getting Started

### Prerequisites

- Flutter SDK (stable channel)
- An active Google Gemini API key.

### Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/ahmed-khedrovica/chatbot.git
    cd chatbot
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Configure API Key:**
    You must add your Google Gemini API key to run the application. Open the following file:
    `lib/features/chat/data/services/gemenai_chat_service.dart`

    Find the `x-goog-api-key` header and replace the placeholder key with your own.

    ```dart
    // In lib/features/chat/data/services/gemenai_chat_service.dart
    
    // ...
    options: Options(
      headers: {
        "Content-Type": "application/json",
        "x-goog-api-key": "YOUR_API_KEY_HERE", // <-- REPLACE THIS
      },
    ),
    // ...
    ```

### Running the Application

To run the app on a connected device or simulator, use the following command:

```bash
flutter run
```

## Testing

The project includes a comprehensive test suite.

- **Run Unit and Widget Tests:**
  ```bash
  flutter test
  ```

- **Run Integration Tests with Patrol:**
  Ensure you have the `patrol_cli` installed. If not, run:
  ```bash
  dart pub global activate patrol_cli
  ```
  Then, run the integration tests:
  ```bash
  patrol test
