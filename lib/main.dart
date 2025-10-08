import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter x Dart Portfolio',
      debugShowCheckedModeBanner: false,

      // Light Theme (Red background)
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          255,
          59,
          59,
        ), // 🔴 Light red background
      ),

      // Dark Theme (Deep red background)
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          139,
          0,
          0,
        ), // 🔴 Dark red background
      ),

      themeMode: _themeMode,
      home: HomePage(onToggleTheme: toggleTheme, themeMode: _themeMode),
    );
  }
}
