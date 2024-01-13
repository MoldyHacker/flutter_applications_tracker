import 'package:applications_tracker/models/application.dart';
import 'package:applications_tracker/models/job_position.dart';
import 'package:applications_tracker/models/organization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;
final authUid = FirebaseAuth.instance.currentUser!.uid;

// TODO: Make this list dynamic
List<String> organizationsList = <String>['Google', 'Facebook'];

class NewApplication extends StatefulWidget {
  const NewApplication({super.key, required this.onAddApplication});

  final void Function(Application application) onAddApplication;

  @override
  State<NewApplication> createState() => _NewApplicationState();
}

class _NewApplicationState extends State<NewApplication> {
  final _formKey = GlobalKey<FormState>();
  var _isValidatingAndUploading = false;

  final _organizationNameController = TextEditingController();
  bool _organizationNameIsValid = true;
  final _organizationLocationController = TextEditingController();
  final _organizationWebsiteController = TextEditingController();

  final _positionTitleController = TextEditingController();
  final _positionWageLowerBoundController = TextEditingController();
  final _positionWageUpperBoundController = TextEditingController();
  JobType _positionType = JobType.values.first;
  WageType _positionWageType = WageType.values.first;
  WorkplaceSetting _positionSettingType = WorkplaceSetting.values.first;

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
    final originalDate = _dateApplied ?? now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _dateApplied = pickedDate ?? originalDate;
    });
  }

  // Retrieve the organization document id if it exists, otherwise add it
  Future<String> _getOrganizationDocumentId() async {
    var querySnapshot = await db
        .collection('users/$authUid/organizations')
        .where('name', isEqualTo: _organizationNameController.text.trim())
        .get();
    if (querySnapshot.docs.isEmpty) {
      return _addOrganization();
    } else {
      return querySnapshot.docs.first.id;
    }
  }

  // Add the organization to the database and return the document id
  Future<String> _addOrganization() async {
    Organization organization = Organization(
      name: _organizationNameController.text.trim(),
      location: _organizationLocationController.text.isNotEmpty
          ? _organizationLocationController.text.trim()
          : null,
      website: _organizationWebsiteController.text.isNotEmpty
          ? _organizationWebsiteController.text.trim()
          : null,
    );
    DocumentReference docRef = await db
        .collection('users/$authUid/organizations')
        .add(organization.toFirestore());

    return docRef.id;
  }

  // Add the position to the database and return the document id
  Future<String> _addPosition() async {
    String organizationDocumentId = await _getOrganizationDocumentId();
    JobPosition position = JobPosition(
      title: _positionTitleController.text.trim(),
      organizationId: organizationDocumentId,
      jobType: JobType.values.byName(_positionType.name),
      workplaceSetting:
          WorkplaceSetting.values.byName(_positionSettingType.name),
      wageType: WageType.values.byName(_positionWageType.name),
      wageLowerBound: _positionWageLowerBoundController.text.isNotEmpty
          ? double.tryParse(_positionWageLowerBoundController.text)
          : null,
      wageUpperBound: _positionWageUpperBoundController.text.isNotEmpty
          ? double.tryParse(_positionWageUpperBoundController.text)
          : null,
    );
    DocumentReference docRef = await db
        .collection('users/$authUid/positions')
        .add(position.toFirestore());
    return docRef.id;
  }

  // Add the application to the database
  Future<String> _addApplication() async {
    String positionDocumentId = await _addPosition();
    Application application = Application(
      jobPositionId: positionDocumentId,
      jobTitle: _positionTitleController.text.trim(),
      organizationName: _organizationNameController.text.trim(),
      dateApplied: _dateApplied!,
      dateUpdated: _dateApplied!,
      applicationMethod: _applicationMethodController.text.isNotEmpty
          ? _applicationMethodController.text.trim()
          : null,
      applicationUrl: _applicationUrlController.text.isNotEmpty
          ? _applicationUrlController.text.trim()
          : null,
    );
    DocumentReference docRef = await db
        .collection('users/$authUid/applications')
        .add(application.toFirestore());
    return docRef.id;
  }

  Future<String?> _validateFormAndAddApplication() async {
    String helpText = 'Please fill in all required fields. \n\n';
    bool formIsValid = true;
    setState(() {
      _isValidatingAndUploading = true;
    });
    if (_organizationNameController.text.length < 3 ||
        _organizationNameController.text.length > 50) {
      _organizationNameIsValid = false;
      formIsValid = false;
      helpText += 'Organization name must be between 3 and 50 characters. \n';
    } else {
      _organizationNameIsValid = true;
    }
    if (!_formKey.currentState!.validate()) {
      formIsValid = false;
      helpText += 'Position title must be between 3 and 50 characters. \n';
    }
    if (!formIsValid) {
      showAdaptiveDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Entry Error'),
          content: Text(helpText),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      setState(() {
        _isValidatingAndUploading = false;
      });
      return null;
    }
    return await _addApplication();
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
                errorText: _organizationNameIsValid
                    ? null
                    : 'Please enter an organization name.',
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
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: _positionTitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a position title.';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Position Title',
                    border: OutlineInputBorder(),
                  ),
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
                                items: JobType.values
                                    .map<DropdownMenuItem<JobType>>((jobType) {
                                  return DropdownMenuItem<JobType>(
                                    value: jobType,
                                    child: Text(jobType.toString()),
                                  );
                                }).toList(),
                                onChanged: (JobType? value) {
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
                                items: WageType.values
                                    .map<DropdownMenuItem<WageType>>(
                                        (WageType value) {
                                  return DropdownMenuItem<WageType>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (WageType? value) {
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
                                items: WorkplaceSetting.values
                                    .map<DropdownMenuItem<WorkplaceSetting>>(
                                        (WorkplaceSetting value) {
                                  return DropdownMenuItem<WorkplaceSetting>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (WorkplaceSetting? value) {
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
                onStepContinue: () async {
                  final navigator = Navigator.of(context);
                  if (_currentStep < _getSteps().length - 1) {
                    setState(() => _currentStep++);
                  } else {
                    if (await _validateFormAndAddApplication() != null) {
                      navigator.pop();
                    }
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
                              ? _isValidatingAndUploading
                                  ? const CircularProgressIndicator.adaptive()
                                  : const Text('Finish')
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
