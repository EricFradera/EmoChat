import 'package:flutter/material.dart';

class DestinationUser {
  String senderName = '';
  String message = '';
  String profilePicture = '';
  String senderUid = '';
  DestinationUser(
      {required this.senderName,
      required this.message,
      required this.profilePicture,
      required this.senderUid});

  DestinationUser.empty();
}
