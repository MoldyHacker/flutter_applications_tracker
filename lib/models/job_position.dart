import 'package:cloud_firestore/cloud_firestore.dart';

enum WorkplaceSetting {
  remote('Remote'),
  hybrid('Hybrid'),
  office('Office'),
  other('Other');

  const WorkplaceSetting(this.setting);

  final String setting;

  @override
  String toString() => setting;
}

enum JobType {
  fullTime('Full Time'),
  partTime('Part Time'),
  internship('Internship'),
  contract('Contract'),
  freelance('Freelance'),
  temporary('Temporary'),
  seasonal('Seasonal'),
  other('Other');

  const JobType(this.type);

  final String type;

  @override
  String toString() => type;
}

enum WageType {
  salary('Salary'),
  hourly('Hourly');

  const WageType(this.type);

  final String type;

  @override
  String toString() => type;
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
      if (jobType != null) 'jobType': jobType?.index,
      if (workplaceSetting != null)'workplaceSetting': workplaceSetting?.index,
      if (description != null)'description': description,
      if (location != null)'location': location,
      if (wageLowerBound != null)'wageLowerBound': wageLowerBound,
      if (wageUpperBound != null)'wageUpperBound': wageUpperBound,
      if (wageType != null)'wageType': wageType?.index,
      if (requirements != null)'requirements': requirements,
      if (preferences != null)'preferences': preferences,
    };
  }
}