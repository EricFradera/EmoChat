import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String sender;
  String reciever;
  String message;
  Timestamp timestamp;

  ChatMessage(
      {required this.sender,
      required this.reciever,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'reciever': reciever,
        'message': message,
        'timestamp': timestamp,
      };
}
