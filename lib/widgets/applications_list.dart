import 'package:applications_tracker/widgets/application_card/application_card_contact.dart';
import 'package:applications_tracker/widgets/application_card/application_card_subtitle.dart';
import 'package:applications_tracker/widgets/application_card/application_card_title.dart';
import 'package:flutter/material.dart';

import 'package:expansion_tile_card/expansion_tile_card.dart';

final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
final List<int> colorCodes = <int>[600, 500, 100];
final List<Map<String, String>> actionItems = [
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
final List<Map<String, String>> applications = [
  {
    'companyName': 'Milwaukee Tool',
    'positionTitle': 'Senior Software Engineer',
    'dateApplied': '12/23/23',
    'dateUpdated': '1/4/24',
    'contactName': 'Mike Walden',
    'contactTitle': 'IT Manager',
    'contactPhone': '+143 (555)-555-5555',
    'contactEmail': 'example@example.com',
    'notes': 'Notes',
    'actionItems': 'Action Items',
  },
  {
    'companyName': 'Company Name',
    'positionTitle': 'Position Title',
    'contactName': 'Contact Name',
    'contactPhone': 'Contact Phone',
    'contactEmail': 'Contact Email',
    'dateApplied': 'Date Applied',
    'dateUpdated': 'Date Updated',
    'notes': 'Notes',
    'actionItems': 'Action Items',
  },
  {
    'companyName': 'Company Name',
    'positionTitle': 'Position Title',
    'contactName': 'Contact Name',
    'contactPhone': 'Contact Phone',
    'contactEmail': 'Contact Email',
    'dateApplied': 'Date Applied',
    'dateUpdated': 'Date Updated',
    'notes': 'Notes',
    'actionItems': 'Action Items',
  },
  {
    'companyName': 'Company Name',
    'positionTitle': 'Position Title',
    'contactName': 'Contact Name',
    'contactPhone': 'Contact Phone',
    'contactEmail': 'Contact Email',
    'dateApplied': 'Date Applied',
    'dateUpdated': 'Date Updated',
    'notes': 'Notes',
    'actionItems': 'Action Items',
  },
  {
    'companyName': 'Company Name',
    'positionTitle': 'Position Title',
    'contactName': 'Contact Name',
    'contactPhone': 'Contact Phone',
    'contactEmail': 'Contact Email',
    'dateApplied': 'Date Applied',
    'dateUpdated': 'Date Updated',
    'notes': 'Notes',
    'actionItems': 'Action Items',
  },
  {
    'companyName': 'Company Name',
    'positionTitle': 'Position Title',
    'contactName': 'Contact Name',
    'contactPhone': 'Contact Phone',
    'contactEmail': 'Contact Email',
    'dateApplied': 'Date Applied',
    'dateUpdated': 'Date Updated',
    'notes': 'Notes',
    'actionItems': 'Action Items',
  },
  {
    'companyName': 'Company Name',
    'positionTitle': 'Position Title',
    'contactName': 'Contact Name',
    'contactPhone': 'Contact Phone',
    'contactEmail': 'Contact Email',
    'dateApplied': 'Date Applied',
    'dateUpdated': 'Date Updated',
    'notes': 'Notes',
    'actionItems': 'Action Items',
  },
];

double itemHeight = 50.0;
double listViewHeight = 3 * itemHeight;

class ApplicationsList extends StatefulWidget {
  const ApplicationsList({super.key});

  @override
  State<ApplicationsList> createState() => _ApplicationsListState();
}

class _ApplicationsListState extends State<ApplicationsList> {
  // final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  // final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            // key: cardA,
            leading: const CircleAvatar(child: Text('A')),
            title: const Text('Tap me!'),
            subtitle: const Text('I expand!'),
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
                  child: Text(
                    """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.

Use me any time you think your app could benefit from being just a bit more Material.

These buttons control the next card down!""",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
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
                      // cardB.currentState?.expand();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.arrow_downward),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Open'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      // cardB.currentState?.collapse();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Close'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      // cardB.currentState?.toggleExpansion();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.swap_vert),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Toggle'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            // key: cardB,
            leading: const CircleAvatar(child: Text('B')),
            title: ApplicationCardTitle(
              companyName: applications[0]['companyName'] ?? 'Company Name',
              dateUpdated: applications[0]['dateUpdated'] ?? 'Date Updated',
            ),
            subtitle: ApplicationCardSubtitle(
              positionTitle:
                  applications[0]['positionTitle'] ?? 'Position Title',
              dateApplied: applications[0]['dateApplied'] ?? 'Date Applied',
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
                        contactName: applications[0]['contactName'] ?? 'Name',
                        contactTitle:
                            applications[0]['contactTitle'] ?? 'Title',
                        contactPhone:
                            applications[0]['contactPhone'] ?? 'Phone',
                        contactEmail:
                            applications[0]['contactEmail'] ?? 'Email',
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: listViewHeight,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: entries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: itemHeight,
                              color: Theme.of(context).highlightColor,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              actionItems[0]['date'] ?? 'Date',
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                actionItems[0]['description'] ??
                                                    'Description',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
  }
}
