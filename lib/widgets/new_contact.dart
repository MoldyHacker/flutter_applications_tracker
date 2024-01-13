import 'package:flutter/material.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  // final Function addContact;

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: ((context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: _formKey,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: _formKey,
                        decoration:
                            const InputDecoration(labelText: 'Organization'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: _formKey,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: _formKey,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: _formKey,
                        decoration: const InputDecoration(labelText: 'Phone'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        key: _formKey,
                        decoration:
                            const InputDecoration(labelText: 'LinkedIn URL'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Add Contact'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
