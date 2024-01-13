import 'dart:async';

import 'package:applications_tracker/models/application.dart';
import 'package:applications_tracker/widgets/application_card/application_card_contact.dart';
import 'package:applications_tracker/widgets/application_card/application_card_list_items.dart';
import 'package:applications_tracker/widgets/application_card/application_card_subtitle.dart';
import 'package:applications_tracker/widgets/application_card/application_card_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

final db = FirebaseFirestore.instance;
final authUid = FirebaseAuth.instance.currentUser!.uid;

final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
final List<int> colorCodes = <int>[600, 500, 100];
List<Map<String, String>> actionItems = [
  {
    'date': '12/4/23',
    'description': 'Action Item1',
  },
  {
    'date': '12/4/23',
    'description': 'Action Item2',
  },
  {
    'date': '12/4/23',
    'description': 'Action Item3',
  },
  {
    'date': '12/4/23',
    'description': 'Action Item',
  },
  {
    'date': '12/4/23',
    'description': 'Action Item',
  },
  {
    'date': '12/4/23',
    'description': 'Action Item',
  },
  {
    'date': '12/4/23',
    'description': 'Action Item',
  },
  {
    'date': '12/4/23',
    'description': 'Action Item',
  },
  {
    'date': '12/4/23',
    'description': 'Action Item',
  },
];
// List<Map<String, String>> applications = [
//   {
//     'companyName': 'Milwaukee Tool',
//     'positionTitle': 'Senior Software Engineer',
//     'dateApplied': '12/23/23',
//     'dateUpdated': '1/4/24',
//     'contactName': 'Mike Walden',
//     'contactTitle': 'IT Manager',
//     'contactPhone': '+143 (555)-555-5555',
//     'contactEmail': 'example@example.com',
//     'notes': 'Notes',
//     'actionItems': 'Action Items',
//   },
//   {
//     'companyName': 'Company Name',
//     'positionTitle': 'Position Title',
//     'contactName': 'Contact Name',
//     'contactPhone': 'Contact Phone',
//     'contactEmail': 'Contact Email',
//     'dateApplied': 'Date Applied',
//     'dateUpdated': 'Date Updated',
//     'notes': 'Notes',
//     'actionItems': 'Action Items',
//   },
//   {
//     'companyName': 'Company Name',
//     'positionTitle': 'Position Title',
//     'contactName': 'Contact Name',
//     'contactPhone': 'Contact Phone',
//     'contactEmail': 'Contact Email',
//     'dateApplied': 'Date Applied',
//     'dateUpdated': 'Date Updated',
//     'notes': 'Notes',
//     'actionItems': 'Action Items',
//   },
// ];
List<Map<String, String>> contact = [
  {
    'contactName': 'Mike Walden',
    'contactTitle': 'IT Manager',
    'contactPhone': '+143 (555)-555-5555',
    'contactEmail': 'example@example.com',
  },
];

double itemHeight = 50.0;
double displayedItems = 3;

class ApplicationsList extends StatefulWidget {
  const ApplicationsList({super.key});

  @override
  State<ApplicationsList> createState() => _ApplicationsListState();
}

class _ApplicationsListState extends State<ApplicationsList> {
  Stream<List<Application>> getActiveApplicationsStream() {
    return db
        .collection('users/$authUid/applications')
        // .where('applicationState', isEqualTo: ApplicationState.active.index)
        .orderBy('dateApplied', descending: false)
        // .orderBy('dateUpdated', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Application.fromFirestore(doc, null))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return StreamBuilder<List<Application>>(
      stream: getActiveApplicationsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return const Text('No active applications found');
        }

        List<Application> applications = snapshot.data!;

        return ListView(
          children: <Widget>[
            for (var application in applications)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ExpansionTileCard(
                  // key: cardB,
                  leading: const CircleAvatar(child: Text('B')),
                  title: ApplicationCardTitle(
                    companyName: application.organizationName,
                    dateUpdated: formatter.format(
                        application.dateUpdated ?? application.dateApplied),
                  ),
                  subtitle: ApplicationCardSubtitle(
                    positionTitle: application.jobTitle,
                    dateApplied: formatter.format(application.dateApplied),
                  ),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            ApplicationCardContact(
                              contactName: contact[0]['contactName'] ?? 'Name',
                              contactTitle:
                                  contact[0]['contactTitle'] ?? 'Title',
                              contactPhone:
                                  contact[0]['contactPhone'] ?? 'Phone',
                              contactEmail:
                                  contact[0]['contactEmail'] ?? 'Email',
                            ),
                            const SizedBox(height: 10),
                            ApplicationCardListItems(
                              listItems: actionItems,
                              onPressed: () {},
                              itemHeight: itemHeight,
                              displayedItems: displayedItems,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      buttonHeight: 52.0,
                      buttonMinWidth: 90.0,
                      children: <Widget>[
                        TextButton(
                          style: flatButtonStyle,
                          onPressed: () {
                            // cardA.currentState?.expand();
                          },
                          child: const Column(
                            children: <Widget>[
                              Icon(Icons.note_add_outlined),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Add Note'),
                            ],
                          ),
                        ),
                        TextButton(
                          style: flatButtonStyle,
                          onPressed: () {
                            // cardA.currentState?.collapse();
                          },
                          child: const Column(
                            children: <Widget>[
                              Icon(Icons.edit_outlined),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        TextButton(
                          style: flatButtonStyle,
                          onPressed: () {
                            // cardA.currentState?.toggleExpansion();
                          },
                          child: const Column(
                            children: <Widget>[
                              Icon(Icons.add_task_outlined),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Add Action'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
