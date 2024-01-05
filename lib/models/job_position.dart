enum WorkplaceSetting {
  remote,
  hybrid,
  inPerson,
}

enum JobType {
  fullTime,
  partTime,
  internship,
  contract,
  temporary,
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
  final bool? isSalary;
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
    this.isSalary,
    this.requirements,
    this.preferences,
  });
}