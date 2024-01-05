class User {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  User({
    this.id = '',
    required this.email,
    required this.name,
    this.photoUrl,
  });
}
