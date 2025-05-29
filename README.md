# Flutter CRUD Application

A simple Flutter application demonstrating CRUD operations with SQLite database and Provider state management.

## Features

- ✅ Create, Read, Update, and Delete items
- ✅ Local SQLite database storage
- ✅ Provider state management
- ✅ Form validation
- ✅ Error handling with user feedback
- ✅ Confirmation dialogs for destructive actions
- ✅ Pull-to-refresh functionality
- ✅ Clean and intuitive UI

## Prerequisites

- Flutter SDK (>=3.0.0 <4.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/GuillermoRS1/FlutterApp.git
   cd FlutterApp
   ```

2. **Install Dependencies**
   Run the following command to install the required packages:
   ```bash
   flutter pub get
   ```

3. **Set Up the Android Emulator or Device**
   - Ensure you have an Android emulator running or a physical device connected.
   - You can create an emulator using Android Studio or use the command line:
     ```bash
     flutter emulators --create
     flutter emulators --launch <emulator_id>
     ```

4. **Build and Run the Application**
   Use the following command to run the application:
   ```bash
   flutter run
   ```

5. **Access the Application**
   - Once the app is running, you can access it on your emulator or device.
   - You will see the home screen where you can add, edit, and delete items.

## Development Assumptions

- The application uses SQLite for local data storage, and the `sqflite` package is utilized for database operations.
- The `provider` package is used for state management, allowing for efficient updates to the UI when data changes.
- Basic form validation is implemented to ensure that users provide necessary information before submitting.

## Troubleshooting

- If you encounter issues with dependencies, ensure that your Flutter SDK is up to date:
  ```bash
  flutter upgrade
  ```

- For any build issues, try cleaning the project:
  ```bash
  flutter clean
  ```

- If you face problems with the emulator, ensure that the Android Virtual Device (AVD) is properly configured.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
