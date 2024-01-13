import 'package:applications_tracker/models/application.dart';
import 'package:applications_tracker/models/contact.dart';
import 'package:flutter/material.dart';

List<Contact> contacts = [
  // Contact(
  //   id: '1',
  //   name: 'Mike Warden',
  //   title: 'IT Manager',
  //   email: 'example@example.com',
  //   phone: '+1 555-555-5555',
  //   organizationId: 'stringText',
  //   organizationName: 'Google',
  // ),
  // Contact(
  //   id: '2',
  //   name: 'Rich Shoemaker',
  //   title: 'Lead Developer',
  //   email: 'example@example.com',
  //   phone: '+1 555-555-5555',
  //   organizationId: 'stringText',
  //   organizationName: 'Google',
  // ),
];

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('Edit Application Title'),
              Text('Edit Organization'),
              Text('Edit Position'),
              Text('Edit Application'),
              Text('Edit Contacts'),
              // if no contacts, show 'Add Contact' button
              // if contacts, show list of contacts
              // if contacts, show 'Edit Contacts' button
              if (contacts.isEmpty)
                TextButton.icon(
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add Contact'),
                  onPressed: () {},
                ),
              if (contacts.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.person_add_outlined),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        children: [
                          for (var contact in contacts)
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${contact.name}: ',
                                                style: TextStyle(
                                                  fontSize: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .fontSize,
                                                  fontWeight: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .fontWeight,
                                                ),
                                              ),
                                              if (contact.title != null)
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 12),
                                                    Text(
                                                      contact.title!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (contact.email != null)
                                                  Row(
                                                    children: [
                                                      Icon(ContactMethod
                                                          .email.icon),
                                                      const SizedBox(width: 8),
                                                      Text(contact.email!),
                                                    ],
                                                  ),
                                                if (contact.phone != null)
                                                  Row(
                                                    children: [
                                                      Icon(ContactMethod
                                                          .phone.icon),
                                                      const SizedBox(width: 8),
                                                      Text(contact.phone!),
                                                    ],
                                                  ),
                                                if (contact.linkedInUrl != null)
                                                  Row(children: [
                                                    Icon(ContactMethod
                                                        .linkedIn.icon),
                                                    const SizedBox(width: 8),
                                                    Text(contact.linkedInUrl!),
                                                  ]),
                                              ]),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const VerticalDivider(),
                                          IconButton(
                                            onPressed: () {},
                                            icon:
                                                const Icon(Icons.edit_outlined),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              Text('Edit Actions'),
              Text('Edit Notes'),
            ],
          ),
        ));
  }
}
