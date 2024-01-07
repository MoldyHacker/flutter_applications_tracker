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
  void dispose() {
    _companyNameController.dispose();
    _positionTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, contraints) {
      // final width = contraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextField(
                  controller: _companyNameController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Company Name'),
                  ),
                ),
                TextField(
                  controller: _positionTitleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Position Title'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                    Text(
                      _dateApplied == null
                          ? 'No date selected'
                          : formatter.format(_dateApplied!),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Save Application'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
