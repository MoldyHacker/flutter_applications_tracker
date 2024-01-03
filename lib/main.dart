import 'package:applications_tracker/screens/splash.dart';

import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 82, 133, 132),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 82, 133, 132),
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock On!',
      themeMode: ThemeMode.system,
      theme: ThemeData.from(colorScheme: kColorScheme),
      darkTheme: ThemeData.from(colorScheme: kDarkColorScheme),
      home: const SplashScreen(),
    );
  }
}
