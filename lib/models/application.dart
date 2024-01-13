import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Status {
  applied('Applied'),
  interviewing('Interviewing'),
  offered('Offered'),
  rejected('Rejected'),
  accepted('Accepted'),
  withdrawn('Withdrawn'),
  negotiating('Negotiating'),
  drafted('Drafted');

  const Status(this.status);

  final String status;

  @override
  String toString() => status;
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
    required this.dateApplied,
    this.dateUpdated,
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
      dateApplied: (data['dateApplied'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dateUpdated: (data['dateUpdated'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: Status.values[data['status']],
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
      'dateApplied': dateApplied,
      if (dateUpdated != null) 'dateUpdated': dateUpdated,
      if (applicationMethod != null) 'applicationMethod': applicationMethod,
      if (applicationUrl != null) 'applicationUrl': applicationUrl,
      if (resumeId != null) 'resumeId': resumeId,
      if (coverLetter != null) 'coverLetter': coverLetter,
    };
  }
}
