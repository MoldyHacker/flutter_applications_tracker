import 'package:applications_tracker/models/application.dart';
import 'package:applications_tracker/models/contact.dart';
import 'package:applications_tracker/models/organization.dart';
import 'package:applications_tracker/utils/map_utils.dart';
import 'package:applications_tracker/utils/url_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<Contact> contacts = [
  Contact(
    id: '1',
    name: 'Mike Warden',
    title: 'IT Manager',
    email: 'example@example.com',
    phone: '+1 555-555-5555',
    organizationId: 'stringText',
    organizationName: 'Google',
    isPrimary: true,
  ),
  Contact(
    id: '2',
    name: 'Rich Shoemaker',
    title: 'Lead Developer',
    email: 'example@example.com',
    phone: '+1 555-555-5555',
    organizationId: 'stringText',
    organizationName: 'Google',
    isReferral: true,
  ),
];

Organization organization = Organization(
  id: '1',
  name: 'Google',
  website: 'https://google.com',
  industry: 'Technology',
  location: '1600 Amphitheatre Parkway, Mountain View, CA 94043',
  phone: '+1 555-555-5555',
  email: 'support@google.com',
);

Application application = Application(
  id: 'string1',
  jobPositionId: 'jobPositionId',
  jobTitle: 'QA Tester',
  organizationName: 'Google',
  dateApplied: DateTime.now(),
  dateUpdated: DateTime.now(),
  status: Status.applied,
  applicationState: ApplicationState.active,
  applicationMethod: 'LinkedIn',
  applicationUrl: 'somewhere.com',
  resumeId: 'resumeId',
  coverLetter: 'cover letter text',
);

class EditApplicationScreen extends StatelessWidget {
  const EditApplicationScreen({super.key});

  // final Application application;

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
              const Text('Edit Status'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    Text(
                      organization.name,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.titleMedium!.fontWeight,
                      ),
                    ),
                    if (organization.industry != null)
                      Row(
                        children: [
                          const Icon(Icons.business_outlined),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  organization.industry!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        if (organization.phone != null)
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.phone_outlined),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        // UrlUtils.launchEmail(organization.email!);
                                      },
                                      onLongPress: () {
                                        Clipboard.setData(ClipboardData(
                                                text: organization.phone!))
                                            .then((value) =>
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '${organization.phone!} coppied to clipboard!'),
                                                  duration: const Duration(
                                                      seconds: 1),
                                                )));
                                      },
                                      child: Text(
                                        organization.phone!,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (organization.email != null)
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.email_outlined),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        UrlUtils.launchEmail(
                                            organization.email!);
                                      },
                                      onLongPress: () {
                                        Clipboard.setData(ClipboardData(
                                                text: organization.email!))
                                            .then((value) =>
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '${organization.email!} coppied to clipboard!'),
                                                  duration: const Duration(
                                                      seconds: 1),
                                                )));
                                      },
                                      child: Text(
                                        organization.email!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    if (organization.website != null)
                      Row(
                        children: [
                          const Icon(Icons.link_outlined),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  UrlUtils.launchWebUrl(organization.website!);
                                },
                                onLongPress: () {
                                  Clipboard.setData(ClipboardData(
                                          text: organization.website!))
                                      .then((value) =>
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                '${organization.website!} coppied to clipboard!'),
                                            duration:
                                                const Duration(seconds: 1),
                                          )));
                                },
                                child: Text(
                                  organization.website!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (organization.location != null)
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  MapUtils.openMap(
                                      address: organization.location);
                                },
                                onLongPress: () {
                                  Clipboard.setData(ClipboardData(
                                          text: organization.location!))
                                      .then((value) =>
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                '${organization.location!} coppied to clipboard!'),
                                            duration:
                                                const Duration(seconds: 1),
                                          )));
                                },
                                child: Text(
                                  organization.location!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const Text('Edit Position'),
              const Text('Edit Application'),
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
                                              Row(
                                                children: [
                                                  if (contact.isPrimary == true)
                                                    const Icon(
                                                      Icons.star,
                                                      size: 20,
                                                      color: Colors.yellow,
                                                    ),
                                                  Text(
                                                    contact.name,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .fontSize,
                                                      fontWeight:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .fontWeight,
                                                    ),
                                                  ),
                                                  if (contact.isReferral ==
                                                      true)
                                                    const Text(' - Referral'),
                                                ],
                                              ),
                                              if (contact.title != null ||
                                                  contact.organizationName !=
                                                      null)
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 12),
                                                    if (contact
                                                            .organizationName !=
                                                        null)
                                                      Text(
                                                          '${contact.organizationName!}: '),
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
                                                      const Icon(
                                                          Icons.email_outlined),
                                                      const SizedBox(width: 4),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            UrlUtils.launchEmail(
                                                                contact.email!);
                                                          },
                                                          onLongPress: () {
                                                            Clipboard.setData(
                                                                    ClipboardData(
                                                                        text: contact
                                                                            .email!))
                                                                .then((value) =>
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      content: Text(
                                                                          '${contact.email!} coppied to clipboard!'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                    )));
                                                          },
                                                          child: Text(
                                                            organization.email!,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (contact.phone != null)
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.phone_outlined),
                                                      const SizedBox(width: 4),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // UrlUtils.launchEmail(organization.email!);
                                                          },
                                                          onLongPress: () {
                                                            Clipboard.setData(
                                                                    ClipboardData(
                                                                        text: contact
                                                                            .phone!))
                                                                .then((value) =>
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      content: Text(
                                                                          '${contact.phone!} coppied to clipboard!'),
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                    )));
                                                          },
                                                          child: Text(
                                                            contact.phone!,
                                                          ),
                                                        ),
                                                      ),
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
