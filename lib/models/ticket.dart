import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'messages.dart';

class Ticket extends Equatable {
  final String id;
  // final UserModel user;
  final String description;
  final String service;
  final int sensitivity;
  final int status;
  final String title;
  final int createdAt;
  final int updatedAt;
  final String image;
  final List<Message> messages;

  const Ticket({
    required this.id,
    // required this.user,
    required this.description,
    required this.service,
    required this.status,
    required this.sensitivity,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.messages,
  });

  @override
  List<Object?> get props => [
        id,
        // user,
        description,
        service,
        status,
        title,
        createdAt,
        updatedAt,
        image,
        messages,
      ];

  factory Ticket.fromMap(Map<String, dynamic> map) {
    print(map);
    return Ticket(
      id: map['id'],
      // user: UserModel.fromMap(map['customerID'], map['customer']),
      description: map['description'],
      service: map['service'],
      status: map['status'],
      sensitivity: map['sensitivity'],
      title: map['title'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      image: map['image'],
      messages: map['messages'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'user': user.toMap(),
      'description': description,
      'service': service,
      'status': status,
      'senstivity': sensitivity,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'image': image,
      'messages': messages,
    };
  }

  factory Ticket.fromFirestore(DocumentSnapshot<Map<String, dynamic>> docMap) {
    final Map<String, dynamic> map = docMap.data()!;
    map.putIfAbsent('id', () => docMap.id);
    return Ticket(
      id: map['id'],
      // user: UserModel.fromMap(map['customerID'], map['customer']),
      description: map['description'],
      service: map['service'],
      status: map['status'],
      title: map['title'],
      sensitivity: map['sensitivity'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      image: map['image'],
      messages:
          (map['messages'] as List).map((e) => Message.fromMap(e)).toList(),
    );
  }
}
