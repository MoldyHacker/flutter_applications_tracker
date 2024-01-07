import 'package:applications_tracker/models/application.dart';
import 'package:applications_tracker/widgets/applications_list.dart';
import 'package:applications_tracker/widgets/main_drawer.dart';
import 'package:applications_tracker/widgets/new_application.dart';
// import 'package:applications_tracker/widgets/test.dart';
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
      builder: (ctx) => NewApplication(onAddApplication: _addApplication),
    );
  }

  void _addApplication(Application application) {
    setState(() {
      // _activeApplications.add(application);
    });
  }

  void _removeApplication(String id) {
    setState(() {
      // _archivedApplications.add(application);
      // _activeApplications.removeWhere((application) => application.id == id);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Application Archived.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              // _registeredApplications.insert(applicationIndex, application);
            });
          },
        ),
      ),
    );
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
