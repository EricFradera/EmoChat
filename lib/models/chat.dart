class Chat {
  String uid1 = '';
  String uid2 = '';

  Chat.empty();

  Chat({required this.uid1, required this.uid2});

  Chat.fromJson(Map<String, dynamic> json)
      : uid1 = json['uid1'],
        uid2 = json['uid2'];

  Map<String, dynamic> toJson() => {
        'uid1': uid1,
        'uid2': uid2,
      };
}
