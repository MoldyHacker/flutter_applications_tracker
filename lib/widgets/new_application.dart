import 'package:applications_tracker/models/application.dart';
import 'package:flutter/material.dart';

List<String> organizationsList = <String>['Google', 'Facebook'];

List<String> applicationMethodsList = <String>[
  'Company Website',
  'LinkedIn',
  'Indeed',
  'Glassdoor',
  'ZipRecruiter',
  'Monster',
  'CareerBuilder',
  'AngelList',
  'Hired',
  'Other'
];

List<String> positionTypeList = <String>[
  'Full Time',
  'Part Time',
  'Internship',
  'Contractor',
  'Freelance',
  'Temporary',
  'Seasonal',
  'Other'
];

List<String> positionWageTypeList = <String>[
  'Salary',
  'Hourly',
  'Commission',
  'Other'
];

List<String> positionSettingTypeList = <String>[
  'Office',
  'Remote',
  'Hybrid',
  'Other'
];

class NewApplication extends StatefulWidget {
  const NewApplication({super.key, required this.onAddApplication});

  final void Function(Application application) onAddApplication;

  @override
  State<NewApplication> createState() => _NewApplicationState();
}

class _NewApplicationState extends State<NewApplication> {
  final _organizationNameController = TextEditingController();
  final _organizationLocationController = TextEditingController();
  final _organizationWebsiteController = TextEditingController();
  final _positionTitleController = TextEditingController();
  final _positionWageLowerBoundController = TextEditingController();
  final _positionWageUpperBoundController = TextEditingController();
  final _positionSettingTypeController = TextEditingController();
  final _applicationMethodController = TextEditingController();

  String _positionType = positionTypeList.first;
  String _positionWageType = positionWageTypeList.first;
  String _positionSettingType = positionSettingTypeList.first;

  DateTime? _dateApplied = DateTime.now();

  int _currentStep = 0;

  @override
  void dispose() {
    _organizationNameController.dispose();
    _organizationLocationController.dispose();
    _organizationWebsiteController.dispose();
    _positionTitleController.dispose();
    _positionWageLowerBoundController.dispose();
    _positionWageUpperBoundController.dispose();
    _positionSettingTypeController.dispose();
    _applicationMethodController.dispose();
    super.dispose();
  }

  void _validate() {
    _organizationNameController.text.isNotEmpty;
  }

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
        content: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 5),
              width: double.infinity,
              child: DropdownMenu(
                controller: _organizationNameController,
                requestFocusOnTap: true,
                enableFilter: true,
                width: 320,
                label: const Text('Organization Name'),
                dropdownMenuEntries: organizationsList
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
            ),
            ExpansionTile(
              title: const Text('Optional'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _organizationLocationController,
                        maxLength: 250,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on_outlined),
                        ),
                      ),
                      TextField(
                        controller: _organizationWebsiteController,
                        maxLength: 250,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                          labelText: 'Website',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.link_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Position'),
        content: Column(
          children: [
            TextField(
              controller: _positionTitleController,
              maxLength: 50,
              decoration: const InputDecoration(
                labelText: 'Position Title',
                border: OutlineInputBorder(),
              ),
            ),
            ExpansionTile(
              title: const Text('Optional'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text('Position Type:   '),
                          DropdownButton(
                              value: _positionType,
                              items: positionTypeList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _positionType = value!;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Wage Type:   '),
                          DropdownButton(
                              value: _positionWageType,
                              items: positionWageTypeList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _positionWageType = value!;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Wage Range'),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _positionWageLowerBoundController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.attach_money),
                                  border: OutlineInputBorder(),
                                  counterText: '',
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child:
                                  Text(' - ', style: TextStyle(fontSize: 28)),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _positionWageUpperBoundController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.attach_money),
                                  border: OutlineInputBorder(),
                                  counterText: '',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Text('Work Setting:   '),
                          DropdownButton(
                              value: _positionSettingType,
                              items: positionSettingTypeList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _positionSettingType = value!;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Application Info'),
        content: Column(
          children: [
            Row(
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
            ExpansionTile(
              title: const Text('Optional'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: double.infinity,
                        child: DropdownMenu(
                          controller: _applicationMethodController,
                          requestFocusOnTap: true,
                          enableFilter: true,
                          width: 310,
                          label: const Text('Application Method'),
                          dropdownMenuEntries: applicationMethodsList
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
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
