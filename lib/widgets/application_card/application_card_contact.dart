import 'package:flutter/material.dart';

class ApplicationCardContact extends StatelessWidget {
  const ApplicationCardContact({
    super.key,
    required this.contactName,
    required this.contactTitle,
    this.contactPhone,
    this.contactEmail,
  });

  final String contactName;
  final String contactTitle;
  final String? contactPhone;
  final String? contactEmail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              const Icon(Icons.info_outline),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contactName,
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      contactTitle,
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 165,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.contact_phone_outlined),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      contactPhone ?? 'Contact Phone',
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.contact_mail_outlined),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      contactEmail ?? 'Contact Email',
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
