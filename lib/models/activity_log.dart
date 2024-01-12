import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityLog {
  final String id;
  final String userId;
  final Timestamp timestamp;
  final String description;

  ActivityLog({
    this.id = '',
    required this.userId,
    required this.description,
  }) : timestamp = Timestamp.now();

  factory ActivityLog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ActivityLog(
      id: doc.id,
      userId: data['userId'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'timestamp': Timestamp.now(),
      'description': description,
    };
  }



}