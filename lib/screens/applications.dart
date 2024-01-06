import 'package:applications_tracker/widgets/applications_list.dart';
import 'package:applications_tracker/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
  }

  // _openAddApplicationScreen() {
  //   Navigator.of(context).pushNamed('/add-application');
  // }

  _openAddApplicationOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return const Text('Add Application');
        });
  }

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
            onPressed: _openAddApplicationOverlay,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: const ApplicationsList(),
    );
  }
}
