import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Organization.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data()!;
    return Organization(
      id: snapshot.id,
      name: data['name'] ?? '',
      industry: data['industry'],
      location: data['location'],
      email: data['email'],
      website: data['website'],
      phoneNumber: data['phoneNumber'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'industry': industry ?? FieldValue.delete(),
      'location': location ?? FieldValue.delete(),
      'email': email ?? FieldValue.delete(),
      'website': website ?? FieldValue.delete(),
      'phoneNumber': phoneNumber ?? FieldValue.delete(),
    };
  }
}
