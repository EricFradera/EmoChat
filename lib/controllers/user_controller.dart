import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserController {
  //if user is not in database adds, else do nothing
  Future<bool> tryAddUser(User user) async {
    FirebaseFirestore.instance.collection("users").add(user.toJson());
    var db = FirebaseFirestore.instance;
    final query =
        await db.collection("users").where('uid', isEqualTo: user.uid).get();

    for (var doc in query.docs) {
      print(doc.data().entries);
    }

    return true;
  }
}
