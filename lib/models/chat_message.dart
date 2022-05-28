import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String chatId;
  String sender;
  String reciever;
  String message;
  Timestamp timestamp;
  int emotion = 0;

  ChatMessage(
      {required this.chatId,
      required this.sender,
      required this.reciever,
      required this.message,
      required this.timestamp,
      required this.emotion});

  Map<String, dynamic> toJson() => {
        'chatId': chatId,
        'sender': sender,
        'reciever': reciever,
        'message': message,
        'timestamp': timestamp,
        'emotion': emotion
      };

  ChatMessage.fromJson(Map<String, dynamic> json)
      : chatId = json['chatId'],
        sender = json['sender'],
        reciever = json['reciever'],
        message = json['message'],
        timestamp = json['timestamp'],
        emotion = json['emotion'];
}
