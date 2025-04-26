# To-Do App

A Flutter-based To-Do application that allows users to manage their tasks efficiently. The app uses the **BLoC (Business Logic Component)** architecture for state management and persists tasks in a local SQLite database.

## Features

- Add, update, and delete tasks.
- Filter tasks by status: All, Completed, or Pending.
- Toggle between Light and Dark themes.
- Persistent task storage using a local SQLite database.
- Task due date functionality (optional).
- Display task priority (optional).

## Architecture

The app is built using the **BLoC architecture**, which separates the business logic from the UI. This ensures a clean and maintainable codebase. It follows the **Event-Driven State Management** pattern.

### Key Components

1. **BLoC**: Handles the business logic for tasks and theme management.
2. **Events**: Define user actions (e.g., adding a task, toggling the theme).
3. **States**: Represent the app's state (e.g., list of tasks, current theme).
4. **UI**: Reacts to state changes and dispatches events.

## Screens

- **Home Page**: Displays the list of tasks with filtering options.
- **Add Task Popup**: Allows users to add new tasks.
- **Settings Page**: Lets users toggle between Light and Dark themes.

## Getting Started

### Prerequisites

- Flutter SDK installed on your system.
- A code editor like Android Studio or Visual Studio Code.

## Setup

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    ```

2.  **Navigate to the project directory:**
    ```bash
    cd <project_directory>
    ```

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
## Structure

lib/
├── blocs/
│   ├── setting/
│   │   ├── theme_bloc.dart
│   │   ├── theme_event.dart
│   │   └── theme_state.dart
│   └── todo/
│       ├── todo_bloc.dart
│       ├── todo_events.dart
│       └── todo_states.dart
├── models/
│   └── task_model.dart
├── screens/
│   ├── add_task_popup.dart
│   ├── confirmation_dialog.dart
│   ├── home_page.dart
│   └── setting_page.dart
├── services/
│   └── database_service.dart
└── main.dart

## Dependencies
flutter_bloc: For state management using the BLoC pattern.

sqflite: For local database storage.

path_provider: For accessing the device's file system.

How to Use
Add a Task: Tap the "+" button to add a new task.

Mark as Completed: Use the checkbox to mark a task as completed.

Delete a Task: Tap the delete icon to remove a task.

Filter Tasks: Use the menu to filter tasks by status (All, Completed, Pending).

Change Theme: Go to the settings page to toggle between Light and Dark themes.

## Flutter info
This project uses Semantic Versioning for version control.

Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel stable, 3.27.1, on Microsoft Windows [Version 10.0.22621.2070], locale en-IN)
[√] Windows Version (Installed version of Windows is version 10 or higher)
[!] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
X cmdline-tools component is missing
Run `path/to/sdkmanager --install "cmdline-tools;latest"`
See https://developer.android.com/studio/command-line for more details.
X Android license status unknown.
Run `flutter doctor --android-licenses` to accept the SDK licenses.
See https://flutter.dev/to/windows-android-setup for more details.
[√] Chrome - develop for the web
[X] Visual Studio - develop Windows apps
X Visual Studio not installed; this is necessary to develop Windows apps.
Download at https://visualstudio.microsoft.com/downloads/.
Please install the "Desktop development with C++" workload, including all of its default components
[!] Android Studio (version 2024.1)
X Unable to determine bundled Java version.
[√] Android Studio (version 2024.2)
[√] VS Code (version 1.99.0)
[√] Connected device (4 available)
[√] Network resources

! Doctor found issues in 3 categories.



Future Updates: Planned improvements include adding task priority and due date, as well as task reminders.