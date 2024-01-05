class Note {
  final String uid;
  final String applicationId;
  final String content;
  final DateTime? createdDate;
  final DateTime? updatedDate;

  Note({
    required this.uid,
    required this.applicationId,
    required this.content,
    this.createdDate,
    this.updatedDate,
  });
}
