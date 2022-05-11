import 'package:flutter/material.dart';

class MessageData {
  MessageData({
    required this.senderName,
    required this.message,
    required this.profilePicture,
  });
  final String senderName;
  final String message;
  final String profilePicture;
}
