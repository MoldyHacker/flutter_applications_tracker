import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum ContactType {
  primary,
  secondary,
}

enum ContactMethod {
  email('Email', Icons.email_outlined),
  phone('Phone', Icons.phone_outlined),
  linkedIn('LinkedIn', Icons.link_outlined);

  const ContactMethod(this.method, this.icon);

  final String method;
  final IconData icon;
}

class Contact {
  final String id;
  final String name;
  final String? title;
  final String? email;
  final String? phone;
  final String? linkedInUrl;
  final String? organizationId;
  final String? organizationName;

  Contact({
    this.id = '',
    required this.name,
    this.title,
    this.email,
    this.phone,
    this.linkedInUrl,
    this.organizationId,
    this.organizationName,
  });

  factory Contact.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return Contact(
      id: snapshot.id,
      name: data['name'] ?? '',
      title: data['title'],
      email: data['email'],
      phone: data['phone'],
      linkedInUrl: data['linkedInUrl'],
      organizationId: data['organizationId'],
      organizationName: data['organizationName'],
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
      if (organizationName != null) 'organizationName': organizationName,
    };
  }
}
