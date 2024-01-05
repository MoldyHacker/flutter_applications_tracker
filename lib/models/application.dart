enum Status {
  applied,
  interviewing,
  offered,
  rejected,
  accepted,
  withdrawn,
  negotiating,
  drafted,
}

class Application {
  String id;
  String jobPositionId;
  Status status;
  DateTime? dateApplied;
  String? resumeId;
  String? coverLetter;

  Application({
    this.id = '',
    required this.jobPositionId,
    this.status = Status.applied,
    this.dateApplied,
    this.resumeId,
    this.coverLetter,
  });
}
