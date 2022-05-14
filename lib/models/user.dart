class User {
  final uid;
  final displayName;
  final email;
  final photoUrl;
  final mood;

  User({this.uid, this.displayName, this.email, this.photoUrl, this.mood});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'userName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        'mood': mood
      };
}
