import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/main_navigation.dart';

void main() {
  runApp(const SmartVowApp());
}

class SmartVowApp extends StatelessWidget {
  const SmartVowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartVow - DAPP Penengah Pernikahan',
      debugShowCheckedModeBanner: false,
      // Light Theme
      theme: AppTheme.lightTheme,
      // Dark Theme
      darkTheme: AppTheme.darkTheme,
      // Ikuti system theme preference
      themeMode: ThemeMode.system,
      // Main Navigation with Bottom Nav
      home: const MainNavigation(),
    );
  }
}
