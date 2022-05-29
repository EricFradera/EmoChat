class DestinationUser {
  String senderName = '';
  String message = '';
  String profilePicture = '';
  String senderUid = '';
  int mood = 0;
  DestinationUser(
      {required this.senderName,
      required this.message,
      required this.profilePicture,
      required this.senderUid,
      required this.mood});

  DestinationUser.empty();
}
