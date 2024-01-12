import 'package:cloud_firestore/cloud_firestore.dart';

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

    factory Contact.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data()!;
    return Contact(
      id: snapshot.id,
      name: data['name'] ?? '',
      title: data['title'] ?? '',
      email: data['email'],
      phone: data['phone'],
      linkedInUrl: data['linkedInUrl'],
      organizationId: data['organizationId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'title': title,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (linkedInUrl != null) 'linkedInUrl': linkedInUrl,
      if (organizationId != null) 'organizationId': organizationId,
    };
  }
}