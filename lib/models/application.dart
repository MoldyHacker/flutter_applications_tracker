import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Application.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data()!;
    return Application(
      id: snapshot.id,
      jobPositionId: data['jobPositionId'],
      dateApplied: data['dateApplied'].toDate(),
      status: Status.values[data['status']],
      // resumeId: data['resumeId'],
      // coverLetter: data['coverLetter'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'jobPositionId': jobPositionId,
      'dateApplied': dateApplied,
      'status': status.index,
      // 'resumeId': resumeId,
      // 'coverLetter': coverLetter,
    };
  }
}
