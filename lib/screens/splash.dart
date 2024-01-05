import 'package:applications_tracker/widgets/applications_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Track\'r',
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              // Icons.account_circle_outlined,
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (String identifier) {},
      // ),

      // floatingActionButton: const MainFab(),

      body: const ApplicationsList(),
    );
  }
}
