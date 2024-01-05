import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:applications_tracker/screens/auth.dart';
import 'package:applications_tracker/screens/splash.dart';


var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 19, 69, 134),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 19, 69, 134),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracker!',
      themeMode: ThemeMode.system,
      theme: ThemeData.from(colorScheme: kColorScheme),
      darkTheme: ThemeData.from(colorScheme: kDarkColorScheme),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.hasData) {
            return const SplashScreen();
          }

          return const AuthScreen();
        },
      ),
    );
  }
}
