import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityLog {
  final String id;
  final String userId;
  final DateTime timestamp;
  final String description;

  ActivityLog({
    this.id = '',
    required this.userId,
    required this.description,
    required this.timestamp,
  });

// Factory constructor to create an ActivityLog object from a Firestore document.
  factory ActivityLog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ActivityLog(
      id: doc.id,
      userId: data['userId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      description: data['description'] ?? '',
    );
  }

  // Method to convert an ActivityLog object into a map for Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'timestamp': Timestamp.fromDate(timestamp),
      'description': description,
    };
  }



}