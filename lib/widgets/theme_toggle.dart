import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 158, 196, 53),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black54),
      titleMedium: TextStyle(color: Colors.black87),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF0A0E23), // deep navy background
    cardColor: const Color(0xFF0D1B2A), // darker blue for cards
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white60),
      titleMedium: TextStyle(color: Colors.white),
    ),
  );
}

class ThemeToggle extends StatefulWidget {
  final VoidCallback onToggle;
  final ThemeMode themeMode;

  const ThemeToggle({
    super.key,
    required this.onToggle,
    required this.themeMode,
  });

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isLight = widget.themeMode == ThemeMode.light;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: IconButton(
          tooltip: isLight ? 'Switch to dark mode' : 'Switch to light mode',
          onPressed: widget.onToggle,
          iconSize: 26,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => RotationTransition(
              turns: Tween(begin: 0.75, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Icon(
              isLight ? Icons.light_mode : Icons.dark_mode,
              key: ValueKey(isLight),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
