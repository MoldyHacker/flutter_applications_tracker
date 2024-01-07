import 'package:applications_tracker/models/application.dart';
import 'package:flutter/material.dart';

class NewApplication extends StatefulWidget {
  const NewApplication({super.key, required this.onAddApplication});

  final void Function(Application application) onAddApplication;

  @override
  State<NewApplication> createState() => _NewApplicationState();
}

class _NewApplicationState extends State<NewApplication> {
  final _organizationNameController = TextEditingController();
  final _positionTitleController = TextEditingController();

  DateTime? _dateApplied = DateTime.now();

  int _currentStep = 0;

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

  List<Step> _getSteps() {
    return [
      Step(
        title: const Text('Organization'),
        content: Container(
          padding: const EdgeInsets.only(top: 5),
          width: double.infinity,
          child: DropdownMenu(
            controller: _organizationNameController,
            requestFocusOnTap: true,
            enableFilter: true,
            width: 320,
            label: const Text('Organization Name'),
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                label: 'Google',
                value: 'Google',
              ),
              DropdownMenuEntry(
                label: 'Facebook',
                value: 'Facebook',
              ),
              DropdownMenuEntry(
                label: 'Amazon',
                value: 'Amazon',
              ),
            ],
          ),
        ),

        // TextField(
        //   controller: _organizationNameController,
        //   maxLength: 50,
        //   decoration: const InputDecoration(labelText: 'Organization Name'),
        // ),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Position'),
        content: TextField(
          controller: _positionTitleController,
          maxLength: 50,
          decoration: const InputDecoration(labelText: 'Position Title'),
        ),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Date Applied'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              onPressed: _presentDatePicker,
            ),
            Text(_dateApplied == null
                ? _dateApplied.toString()
                : formatter.format(_dateApplied!)),
          ],
        ),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  @override
  void dispose() {
    _organizationNameController.dispose();
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
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.fromLTRB(0, 16, 16, keyboardSpace + 16),
            //   child:
            Flexible(
              child: Stepper(
                // type: StepperType.horizontal,
                physics: const ClampingScrollPhysics(),
                currentStep: _currentStep,
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep -= 1);
                  }
                },
                onStepContinue: () {
                  if (_currentStep < _getSteps().length - 1) {
                    setState(() => _currentStep++);
                  }
                },
                onStepTapped: (step) => setState(() => _currentStep = step),
                steps: _getSteps(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        ),
                        ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: _currentStep == _getSteps().length - 1
                              ? const Text('Finish')
                              : const Text('Next'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // ),
          ],
        ),
      );
    });
  }
}
