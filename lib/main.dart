import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'providers/item_provider.dart';
import 'screens/home_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  databaseFactory = databaseFactory;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter CRUD App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF09184D), // Menu color
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFF7B5BF2), // Buttons color
            background: const Color(0xFFEDF2FA), // Background color
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(color: Color(0xFF2F2E2E)), // Title color
            bodyLarge: TextStyle(color: Color(0xFF808085)), // Info color
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B5BF2), // Buttons color
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF09184D)), // Menu color
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF7B5BF2)), // Buttons color
            ),
            labelStyle: const TextStyle(color: Color(0xFF09184D)), // Menu color
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}