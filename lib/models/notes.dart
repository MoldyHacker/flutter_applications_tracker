import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String applicationId;
  final String content;
  final DateTime? createdDate;
  final DateTime? updatedDate;

  Note({
    this.id = '',
    required this.applicationId,
    required this.content,
    this.createdDate,
    this.updatedDate,
  });

    factory Note.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data()!;
    return Note(
      id: snapshot.id,
      applicationId: data['applicationId'] ?? '',
      content: data['content'] ?? '',
      createdDate: data['createdDate']?.toDate() ?? '',
      updatedDate: data['updatedDate']?.toDate() ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'applicationId': applicationId,
      'content': content,
      if (createdDate != null) 'createdDate': createdDate,
      if (updatedDate != null) 'updatedDate': updatedDate,
    };
  }
}
