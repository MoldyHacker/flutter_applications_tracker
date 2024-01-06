class Organization {
  final String id;
  final String name;
  final String? industry;
  final String? location;
  final String? email;
  final String? website;
  final String? phoneNumber;

  Organization({
    this.id = '',
    required this.name,
    this.industry,
    this.location,
    this.email,
    this.website,
    this.phoneNumber,
  });
}
