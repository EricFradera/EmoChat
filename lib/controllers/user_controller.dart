import 'dart:ffi';

import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/destination_User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chat_app/models/user.dart';
import '../models/user.dart';

class UserController extends GetxController {
  //if user is not in database adds, else do nothing

  EmoUser myUser = EmoUser.empty();
  DestinationUser selectedUser = DestinationUser.empty();
  FirebaseFirestore db = FirebaseFirestore.instance;
  String docRef = "";

  /*Future<bool> tryAddUser(EmoUser user) async { NO LONGER USED, OLD VER
    try {
      final query =
          await db.collection("users").where('uid', isEqualTo: user.uid).get();
      if (query.docs.isEmpty) {
        db.collection("users").add(user.toJson());
      }
      return true;
    } catch (e) {
      return false;
    }
  }*/

  Future<void> signInUser() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    //print(userCredential.user!.email.toString());

    EmoUser tempUser = await tryGetUser(userCredential);

    //tryAddUser(tempUser);
    myUser = tempUser;

    update();
  }

  Future<EmoUser> tryGetUser(UserCredential userCred) async {
    try {
      final query = await db
          .collection("users")
          .where("uid", isEqualTo: userCred.user?.uid)
          .get();
      if (query.docs.isEmpty) {
        return createUser(userCred);
      } else {
        var dataList = query.docs.map((doc) {
          return EmoUser(
              uid: doc["uid"],
              displayName: doc["userName"],
              email: doc["email"],
              photoUrl: doc["photoUrl"],
              mood: doc["mood"]);
        });
        return dataList.single;
      }
    } catch (e) {
      return EmoUser.empty();
    }
  }

  EmoUser createUser(UserCredential userCred) {
    EmoUser tempUser = EmoUser(
        uid: userCred.user!.uid,
        displayName: userCred.user!.displayName ?? '',
        email: userCred.user!.email ?? '',
        photoUrl: userCred.user!.photoURL ?? '',
        mood: 0);
    db.collection("users").add(tempUser.toJson());
    return tempUser;
  }

  Future<void> trySingOut() async {
    myUser = EmoUser.empty();
    selectedUser = DestinationUser.empty();
    docRef = "";

    await GoogleSignIn.standard().disconnect();
    update();
  }

  void selectUser(DestinationUser destinationUser) {
    selectedUser = destinationUser;
    update();
  }

  bool isOwnMsg(ChatMessage msg) {
    if (msg.sender == myUser.uid) {
      return true;
    }
    return false;
  }

  String getConversationID() {
    return myUser.uid.hashCode <= selectedUser.senderUid.hashCode
        ? myUser.uid + '' + selectedUser.senderUid
        : selectedUser.senderUid + '' + myUser.uid;
  }

  sendMessage(String message, int emotion) {
    if (!message.isEmpty) {
      ChatMessage msg = ChatMessage(
          chatId: getConversationID(),
          sender: myUser.uid,
          reciever: selectedUser.senderUid,
          message: message,
          timestamp: Timestamp.now(),
          emotion: emotion);

      db.collection("messages").add(msg.toJson());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() {
    return db
        .collection("messages")
        .where("chatId", isEqualTo: getConversationID())
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  changeMood(int i) async {
    if (docRef.isEmpty) {
      QuerySnapshot query = await db
          .collection("users")
          .where("uid", isEqualTo: myUser.uid)
          .get();
      docRef = query.docs.single.reference.id;
    }
    myUser.mood = i;
    await db.collection("users").doc(docRef).update(myUser.toJson());
    update();
  }
}
