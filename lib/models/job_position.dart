import 'package:cloud_firestore/cloud_firestore.dart';

enum WorkplaceSetting {
  remote,
  hybrid,
  office,
  other,
}

enum JobType {
  fullTime,
  partTime,
  internship,
  contract,
  freelance,
  temporary,
  seasonal,
  other,
}

List<String> jobTypeToString = [
  "Full Time",
  "Part Time",
  "Internship",
  "Contract",
  "Freelance",
  "Temporary",
  "Seasonal",
  "Other",
];

enum WageType {
  salary,
  hourly,
  commission,
  other,
}

class JobPosition {
  final String id;
  final String organizationId;
  final String title;
  final JobType? jobType;
  final WorkplaceSetting? workplaceSetting;
  final String? description;
  final String? location;
  final double? wageLowerBound;
  final double? wageUpperBound;
  final WageType? wageType;
  final String? requirements;
  final String? preferences;


  JobPosition({
    this.id = '',
    required this.organizationId,
    required this.title,
    this.jobType,
    this.workplaceSetting,
    this.description,
    this.location,
    this.wageLowerBound,
    this.wageUpperBound,
    this.wageType,
    this.requirements,
    this.preferences,
  });

    factory JobPosition.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data()!;
    return JobPosition(
      id: snapshot.id,
      organizationId: data['organizationId'] ?? '',
      title: data['title'] ?? '',
      jobType: JobType.values[data['jobType']],
      workplaceSetting: WorkplaceSetting.values[data['workplaceSetting']],
      description: data['description'],
      location: data['location'],
      wageLowerBound: data['wageLowerBound'],
      wageUpperBound: data['wageUpperBound'],
      wageType: WageType.values[data['wageType']],
      requirements: data['requirements'],
      preferences: data['preferences'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'organizationId': organizationId,
      'title': title,
      'jobType': jobType?.index ?? FieldValue.delete(),
      'workplaceSetting': workplaceSetting?.index  ?? FieldValue.delete(),
      'description': description ?? FieldValue.delete(),
      'location': location ?? FieldValue.delete(),
      'wageLowerBound': wageLowerBound ?? FieldValue.delete(),
      'wageUpperBound': wageUpperBound ?? FieldValue.delete(),
      'wageType': wageType?.index ?? FieldValue.delete(),
      'requirements': requirements ?? FieldValue.delete(),
      'preferences': preferences ?? FieldValue.delete(),
    };
  }
}