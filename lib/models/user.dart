import 'package:chat_app/models/expressionPreferences.dart';

class User {
  final uid;
  final displayName;
  final email;
  final photoUrl;
  final mood;
  final List<ExpressionPreferences> expressionPreferences = [];

  User({
    this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.mood,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'userName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        'mood': mood,
        'expressionsPreferences':
            expressionPreferences.map((e) => e.toJson()).toList(),
      };
}
