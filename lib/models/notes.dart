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
}
