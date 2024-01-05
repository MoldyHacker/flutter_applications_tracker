import 'package:flutter/material.dart';

class ApplicationCardTitle extends StatelessWidget {
  const ApplicationCardTitle({
    super.key,
    required this.companyName,
    required this.dateUpdated,
  });

  final String companyName;
  final String dateUpdated;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            companyName,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              dateUpdated,
            ),
            const SizedBox(width: 5),
            const Icon(Icons.update_outlined),
          ],
        ),
      ],
    );
  }
}
