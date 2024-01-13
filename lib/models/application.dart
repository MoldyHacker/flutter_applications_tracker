import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Status {
  applied('Applied', 'A', Colors.blue),
  interviewing('Interviewing', 'I', Colors.green),
  offered('Offered', 'O', Colors.orange),
  rejected('Rejected', 'R', Colors.red),
  accepted('Accepted', 'A', Colors.green),
  withdrawn('Withdrawn', 'W', Colors.red),
  negotiating('Negotiating', 'N', Colors.orange),
  drafted('Drafted', 'D', Colors.purple);

  const Status(this.status, this.symbol, this.color);

  final String status;
  final String symbol;
  final Color color;

  @override
  String toString() => status;
}

enum ApplicationState {
  active,
  archived,
}

List<String> applicationMethodsList = <String>[
  'Company Website',
  'LinkedIn',
  'Indeed',
  'Glassdoor',
  'ZipRecruiter',
  'Monster',
  'CareerBuilder',
  'AngelList',
  'Hired',
  'Other'
];

class Application {
  final String id;
  final String jobPositionId;
  final String jobTitle;
  final String organizationName;
  final ApplicationState applicationState;
  final Status status;
  final DateTime dateApplied;
  final DateTime? dateUpdated;
  final String? applicationMethod;
  final String? applicationUrl;
  final String? resumeId;
  final String? coverLetter;

  Application({
    this.id = '',
    required this.jobPositionId,
    required this.jobTitle,
    required this.organizationName,
    this.applicationState = ApplicationState.active,
    required this.dateApplied,
    required this.dateUpdated,
    this.status = Status.applied,
    this.applicationMethod,
    this.applicationUrl,
    this.resumeId,
    this.coverLetter,
  });

  get formattedDateApplied {
    return formatter.format(dateApplied);
  }

  factory Application.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return Application(
      id: snapshot.id,
      jobPositionId: data['jobPositionId'] ?? '',
      jobTitle: data['jobTitle'] ?? '',
      organizationName: data['organizationName'] ?? '',
      dateApplied: (data['dateApplied'] as Timestamp?)!.toDate(),
      dateUpdated: (data['dateUpdated'] as Timestamp?)!.toDate(),
      status: Status.values[data['status']],
      applicationState: ApplicationState.values[data['applicationState']],
      applicationMethod: data['applicationMethod'],
      applicationUrl: data['applicationUrl'],
      resumeId: data['resumeId'],
      coverLetter: data['coverLetter'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'jobPositionId': jobPositionId,
      'jobTitle': jobTitle,
      'organizationName': organizationName,
      'status': status.index,
      'applicationState': applicationState.index,
      'dateApplied': dateApplied,
      'dateUpdated': dateUpdated,
      if (applicationMethod != null) 'applicationMethod': applicationMethod,
      if (applicationUrl != null) 'applicationUrl': applicationUrl,
      if (resumeId != null) 'resumeId': resumeId,
      if (coverLetter != null) 'coverLetter': coverLetter,
    };
  }
}
