import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.account_circle_outlined,
        //     ),
        //   ),
        // ],
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (String identifier) {},
      // ),

      // floatingActionButton: const MainFab(),
      
      // body: const SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.all(10.0),
      //     child: MainChartCard(),
      //   ),
      // ),
    );
  }
}