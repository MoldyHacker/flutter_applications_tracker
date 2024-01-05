import 'package:flutter/material.dart';

class ApplicationCardSubtitle extends StatelessWidget {
  const ApplicationCardSubtitle({
    super.key,
    required this.positionTitle,
    required this.dateApplied,
  });

  final String positionTitle;
  final String dateApplied;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            positionTitle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              dateApplied,
            ),
            const SizedBox(width: 5),
            const Icon(Icons.post_add_outlined),
          ],
        ),
      ],
    );
  }
}
