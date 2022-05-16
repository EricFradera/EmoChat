import 'package:flutter/material.dart';

class MessageData {
  final String senderName;
  final String message;
  final String profilePicture;
  final String senderUid;
  MessageData(
      {required this.senderName,
      required this.message,
      required this.profilePicture,
      required this.senderUid});
}
