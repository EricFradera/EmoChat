import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserController {
  //if user is not in database adds, else do nothing
  Future<bool> tryAddUser(User user) async {
    var db = FirebaseFirestore.instance;
    final query =
        await db.collection("users").where('uid', isEqualTo: user.uid).get();
    if (query.docs.isEmpty) {
      FirebaseFirestore.instance.collection("users").add(user.toJson());
    }
    return true;
  }
}
