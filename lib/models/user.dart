import 'package:chat_app/models/expressionPreferences.dart';

class EmoUser {
  String uid = '';
  String displayName = '';
  String email = '';
  String photoUrl = '';
  String mood = '';
  final List<ExpressionPreferences> expressionPreferences = [];

  EmoUser({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.mood,
  });

  EmoUser.empty();

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
