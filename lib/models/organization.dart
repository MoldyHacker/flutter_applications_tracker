import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  final String id;
  final String name;
  final String? industry;
  final String? location;
  final String? email;
  final String? website;
  final String? phone;

  Organization({
    this.id = '',
    required this.name,
    this.industry,
    this.location,
    this.email,
    this.website,
    this.phone,
  });

  factory Organization.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data()!;
    return Organization(
      id: snapshot.id,
      name: data['name'] ?? '',
      industry: data['industry'],
      location: data['location'],
      email: data['email'],
      website: data['website'],
      phone: data['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      if (industry != null) 'industry': industry,
      if (location != null) 'location': location,
      if (email != null) 'email': email,
      if (website != null) 'website': website,
      if (phone != null) 'phone': phone,
    };
  }
}
