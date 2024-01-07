import 'package:intl/intl.dart';

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

final formatter = DateFormat.yMd();

class Application {
  final String id;
  final String jobPositionId;
  final Status status;
  final DateTime dateApplied;
  final String? resumeId;
  final String? coverLetter;

  Application({
    this.id = '',
    required this.jobPositionId,
    required this.dateApplied,
    this.status = Status.applied,
    this.resumeId,
    this.coverLetter,
  });

  get formattedDateApplied {
    return formatter.format(dateApplied);
  }
}
