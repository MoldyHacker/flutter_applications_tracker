import 'package:flutter/material.dart';

class ApplicationCardSmall extends StatelessWidget {
  const ApplicationCardSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: const Text('Company Name'),
        subtitle: const Text('Position Title'),
      ),
    );
  }
}
