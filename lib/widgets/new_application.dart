import 'package:applications_tracker/models/application.dart';
import 'package:applications_tracker/models/job_position.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

// TODO: Make this list dynamic
List<String> organizationsList = <String>['Google', 'Facebook'];

List<String> positionWageTypeList = WageType.values
    .map((wageType) => wageType.toString().split('.').last)
    .toList();

List<String> positionTypeList = JobType.values
    .map((jobType) => jobType.toString().split('.').last)
    .toList();

List<String> positionSettingTypeList = WorkplaceSetting.values
    .map((workplaceSetting) => workplaceSetting.toString().split('.').last)
    .toList();

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
  String _positionType = positionTypeList.first;
  String _positionWageType = positionWageTypeList.first;
  String _positionSettingType = positionSettingTypeList.first;

  final _applicationMethodController = TextEditingController();
  final _applicationUrlController = TextEditingController();

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

    _applicationMethodController.dispose();
    _applicationUrlController.dispose();
    super.dispose();
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

  // Retrieve the organization document id if it exists, otherwise add it
  Future<String> getOrganizationDocumentId() async {
    String? documentId;
    db
        .collection('users/${auth.currentUser!.uid}/organizations')
        .where('name', isEqualTo: _organizationNameController.text)
        .get()
        .then((QuerySnapshot querySnapshot) {
      documentId = querySnapshot.docs.firstOrNull?.id;
    });
    if (documentId == null) {
      return _addOrganization();
    }
    return documentId!;
  }

  // Add the organization to the database and return the document id
  Future<String> _addOrganization() async {
    DocumentReference docRef = await db
        .collection('users/${auth.currentUser!.uid}/organizations')
        .add({
      'name': _organizationNameController.text,
      'location': _organizationLocationController.text,
      'website': _organizationWebsiteController.text,
    });
    return docRef.id;
  }

  // Add the position to the database and return the document id
  Future<String> _addPosition() async {
    String organizationDocumentId = await getOrganizationDocumentId();
    DocumentReference docRef =
        await db.collection('users/${auth.currentUser!.uid}/positions').add({
      'title': _positionTitleController.text,
      'organization': organizationDocumentId,
      'type': _positionType,
      'wageType': _positionWageType,
      'wageLowerBound': _positionWageLowerBoundController.text,
      'wageUpperBound': _positionWageUpperBoundController.text,
      'settingType': _positionSettingType,
    });
    return docRef.id;
  }

  // Add the application to the database
  void _addApplication() async {
    String positionDocumentId = await _addPosition();
    db.collection('users/${auth.currentUser!.uid}/applications').add({
      'position': positionDocumentId,
      'positionTitle': _positionTitleController.text,
      'organization': _organizationNameController.text,
      'dateApplied': _dateApplied,
      'applicationMethod': _applicationMethodController.text,
      'applicationUrl': _applicationUrlController.text,
    });
  }

  void _validateFormAndAddApplication() {
    if (_organizationNameController.text.isNotEmpty) {
      _addApplication();
    }
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
                        maxLength: 125,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on_outlined),
                        ),
                      ),
                      TextField(
                        controller: _organizationWebsiteController,
                        maxLength: 50,
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Wage Range'),
                      ),
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
                      const SizedBox(height: 16),
                      TextField(
                        controller: _applicationUrlController,
                        maxLength: 50,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                          labelText: 'Application Url',
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
                  } else {
                    _validateFormAndAddApplication();
                    Navigator.of(context).pop();
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
