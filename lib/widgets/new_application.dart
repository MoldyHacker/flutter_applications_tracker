import 'package:applications_tracker/models/application.dart';
import 'package:flutter/material.dart';

class NewApplication extends StatefulWidget {
  const NewApplication({super.key, required this.onAddApplication});

  final void Function(Application application) onAddApplication;

  @override
  State<NewApplication> createState() => _NewApplicationState();
}

class _NewApplicationState extends State<NewApplication> {
  final _companyNameController = TextEditingController();
  final _positionTitleController = TextEditingController();

  DateTime? _dateApplied;

    void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _dateApplied = pickedDate;
    });
  }



@override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}