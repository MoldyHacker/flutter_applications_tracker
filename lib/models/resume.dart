import 'package:cloud_firestore/cloud_firestore.dart';

class Resume {
  final String id;
  final DateTime dateCreated;
  final String version;
  final String fileLink;

  Resume({
    this.id = '',
    required this.dateCreated,
    required this.version,
    required this.fileLink,
  });

    factory Resume.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data()!;
    return Resume(
      id: snapshot.id,
      dateCreated: data['dateCreated'].toDate() ?? '',
      version: data['version'] ?? '',
      fileLink: data['fileLink'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'dateCreated': dateCreated,
      'version': version,
      'fileLink': fileLink,
    };
  }
}