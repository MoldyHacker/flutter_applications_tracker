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
}