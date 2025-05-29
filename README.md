# Flutter CRUD Application

A simple Flutter application demonstrating Create, Read, Update and Delete (CRUD) operations using a local SQLite database and Provider for state management.

## Features

- ✅ Create, Read, Update, Delete items  
- ✅ Local SQLite storage (`sqflite`)  
- ✅ State management with `provider`  
- ✅ Form validation and user feedback  
- ✅ Confirmation dialogs for destructive actions  
- ✅ Pull-to-refresh on list views  
- ✅ Clean and intuitive UI

## Prerequisites

- Flutter SDK (>=3.0.0 <4.0.0)  
- Dart SDK  
- **Java JDK 17** (Android Gradle Plugin requires JDK ≥17)  
- Android Studio or VS Code with Flutter & Dart plugins  
- (Optional) Modern browser for Flutter Web

## Setup Instructions

1. **Clone the repository**  
   ```bash
   git clone https://github.com/GuillermoRS1/FlutterApp.git
   cd FlutterApp
   
2. **Install Dart/Flutter dependencies**
   ```bash
   flutter pub get

3. **Configure JDK 17 for Android builds**
   - Download & install a Java 17 JDK (e.g. Adoptium/Eclipse Temurin).
   - Point Flutter to it:
   ```bash
   flutter config --jdk-dir="C:\Program Files\Java\jdk-17"

   - Verify:
   ```bash
   flutter doctor -v

   You should see:
   • Java binary at: C:\Program Files\Java\jdk-17\bin\java
   • Java version: 17.x

4. **Accept Android SDK licenses**
   ```bash
   flutter doctor --android-licenses

5. **Start an emulator or connect a device**
   - Emulator (Android Studio or CLI):

   ```bash
   flutter emulators --create --name myEmu
   flutter emulators --launch myEmu

   - Physical device: enable USB debugging & set default USB configuration to “File Transfer (MTP)”.

6. **Run the app**
   ```bash
   flutter run

## Flutter Web (Optional)
To run in a browser, we use sqflite_common_ffi_web for SQLite emulation or switch to another web-friendly storage.

1. Add to pubspec.yaml:
   ```yaml
   dependencies:
     sqflite_common_ffi: ^2.2.1
     sqflite_common_ffi_web: ^2.2.1
  
2. In main.dart:

   ```dart
   import 'package:flutter/foundation.dart' show kIsWeb;
   import 'package:flutter/widgets.dart';
   import 'package:sqflite_common_ffi/sqflite_ffi.dart'
     if (dart.library.html) 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     // Initializes the correct implementation for desktop or web
     sqfliteFfiInit();
     runApp(MyApp());
   }

3. Launch in Chrome:
   ```bash
   flutter run -d chrome

**Alternative Web Storage**
Hive + hive_flutter (uses IndexedDB on web)
sembast + sembast_web
Drift/Moor with drift/web.dart (IndexedDB)

**Troubleshooting**
**“Android Gradle plugin requires Java 17”**
- Ensure flutter doctor -v reports Java 17.
- Confirm java -version in your terminal shows 17.x.
- If it still picks Java 11, add to android/gradle.properties:

´´´PROPERTIES
org.gradle.java.home=C:/Program Files/Java/jdk-17

**Device not listed by `adb devices`**
1. Enable USB debugging and set USB mode to File Transfer (MTP).
2. Install OEM USB drivers (Samsung, Xiaomi, etc.).
3. Restart ADB server:

´´´BASH
adb kill-server
adb start-server
adb devices

**Build or dependency issues**

´´´BASH
flutter clean
flutter pub get
flutter run

**SQLite errors on Web**
- Use the sqflite_common_ffi_web initialization above, or
- Switch to one of the alternative web-compatible storages listed.

**License**
MIT © GuillermoRS
