import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Chat',
      theme: ThemeData(
        primaryColor: const Color(0xFF33333A),
        scaffoldBackgroundColor: const Color(0xFF1E1E24),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFE0E0E0)),
        ), // Added closing parenthesis and comma
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF4A90E2),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
