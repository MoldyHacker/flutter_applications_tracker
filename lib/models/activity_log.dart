class ActivityLog {
  final String id;
  final String userId;
  final DateTime timestamp;
  final String activity;

  ActivityLog({
    this.id = '',
    required this.userId,
    required this.activity,
    required this.timestamp,
  });
}