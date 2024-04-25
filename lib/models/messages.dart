import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int createdAt;
  final String text;
  final String? image;
  final String senderName;
  final bool isFromAdmin;

  const Message({
    required this.createdAt,
    required this.text,
    this.image,
    required this.senderName,
    required this.isFromAdmin,
  });

  @override
  List<Object?> get props => [
    createdAt,
    text,
    image,
    senderName,
    isFromAdmin,
  ];

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      createdAt: map['createdAt'],
      text: map['text'],
      image: map['image'],
      senderName: map['senderName'],
      isFromAdmin: map['isFromAdmin'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "createdAt": createdAt,
      "text": text,
      "image": image,
      "senderName": senderName,
      "isFromAdmin": isFromAdmin,
    };
  }
}
