class Contact {
  final String id;
  final String name;
  final String? title;
  final String? email;
  final String? phone;
  final String? linkedInUrl;
  final String? organizationId;
  
  Contact({
    this.id = '',
    required this.name,
    this.title,
    this.email,
    this.phone,
    this.linkedInUrl,
    this.organizationId,
  });
}