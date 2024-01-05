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
  final String id;
  final String jobPositionId;
  final Status status;
  final DateTime? dateApplied;
  final String? resumeId;
  final String? coverLetter;

  Application({
    this.id = '',
    required this.jobPositionId,
    this.status = Status.applied,
    this.dateApplied,
    this.resumeId,
    this.coverLetter,
  });
}
