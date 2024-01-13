import 'package:applications_tracker/models/application.dart';
import 'package:flutter/material.dart';

class EditApplicationScreen extends StatelessWidget {
  const EditApplicationScreen({super.key, required this.application});

  final Application application;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            application.organizationName,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Text('Edit Application Title'),
              Text('Edit Organization'),
              Text('Edit Position'),
              Text('Edit Application'),
              Text('Edit Contacts'),
              Text('Edit Actions'),
              Text('Edit Notes'),
            ],
          ),
        ));
  }
}
